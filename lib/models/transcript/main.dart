import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class TranscriptService {
  Future<Map<String, dynamic>> getTranscript(
      File? file, String language, String apiKey) async {
    if (file == null) {
      throw Exception("File is null");
    }

    var request = http.MultipartRequest('POST',
        Uri.parse('https://care-voice-ai.azurewebsites.net/services/upload'));

    request.fields.addAll({
      'service_name': 'speech_to_text',
      'language': language,
      'api_key': apiKey,
      'platform': Platform.isAndroid ? "ANDROID" : "IOS",
      'encode': Platform.isAndroid ? "OPUS" : "FLAC",
      'extract_entities': "true",
    });

    // Determinar o tipo de MIME do arquivo
    if (!file.path.endsWith('.m4a')) {
      throw Exception("Unsupported file type, only .m4a files are supported");
    }

    try {
      // Adicionar o arquivo à requisição
      var fileStream = http.ByteStream(file.openRead());
      var fileLength = await file.length();

      request.files.add(http.MultipartFile(
        'file',
        fileStream,
        fileLength,
        filename: file.path.split('/').last,
        contentType: MediaType.parse("audio/m4a"),
      ));

      print("Sending request to server..."); // Log de depuração

      // Enviar a requisição
      http.StreamedResponse response = await request.send();

      // Verificar o status da resposta
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print("Response received successfully."); // Log de depuração
        return Map<String, dynamic>.from(jsonDecode(responseData));
      } else {
        throw Exception('Failed to load transcript: ${response.statusCode}');
      }
    } catch (e) {
      print("Error occurred: $e"); // Log de depuração
      return {"transcript": ""};
    }
  }

  Future<Map<String, dynamic>> getEncoder(
      String transcript, String baseText, String apiKey) async {
    try {
      // Construir o corpo da requisição JSON
      var requestBody = {
        'service_name': 'get_encoder',
        'service_args': {
          "platform": Platform.isAndroid ? "android" : "ios",
          "transcript": transcript,
          "original_text": baseText
        },
        'api_key': apiKey,
      };

      print("Sending request to server..."); // Log de depuração

      // Enviar a requisição
      var response = await http.post(
        Uri.parse('https://care-voice-ai.azurewebsites.net/services'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      // Verificar o status da resposta
      if (response.statusCode == 200) {
        print("Response received successfully."); // Log de depuração
        return Map<String, dynamic>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load transcript: ${response.statusCode}');
      }
    } catch (e) {
      print("Error occurred: $e"); // Log de depuração
      return {"status": false, "encoder": null};
    }
  }
}
