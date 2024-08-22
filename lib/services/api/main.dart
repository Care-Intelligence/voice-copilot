import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:voice_copilot/models/assistants/main.dart';
import 'package:voice_copilot/models/metrics/main.dart';
import 'package:voice_copilot/services/logs.dart';

class ApiService {
  Future<bool> saveMetric(String apiKey, Metric args) async {
    bool didWork = false;

    try {
      var requestBody = {
        'service_name': 'save_entities_metrics_metabase',
        'service_args': args.toJson(),
        'api_key': apiKey,
      };
      var response = await http.post(
        Uri.parse('https://care-voice-ai.azurewebsites.net/services'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print("Response received successfully."); // Log de depuração
        var body = Map<String, dynamic>.from(jsonDecode(response.body));

        return body["status"];
      } else {
        throw Exception('Failed to load transcript: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: ${e}");
    }

    return didWork;
  }

  void saveMetrics() {}

  Future<List<Map<String, dynamic>>> useAssistants(
      String apiKey, List<Assistant> assistants, String transcript) async {
    List<Map<String, dynamic>> entities = [];

    try {
      // Construir o corpo da requisição JSON
      var requestBody = {
        'service_args': {
          "transcript": transcript,
          "assistant_ids": assistants.map((e) => e.toJson()["id"]).toList(),
        },
        'api_key': apiKey,
      };

      print("Sending request to server..."); // Log de depuração

      // Enviar a requisição
      var response = await http.post(
        Uri.parse('https://care-voice-ai.azurewebsites.net/use_assistants'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      // Verificar o status da resposta
      if (response.statusCode == 200) {
        print("Response received successfully."); // Log de depuração
        for (Assistant assistant in assistants) {
          for (Map<String, dynamic> entitie
              in jsonDecode(response.body)["entities"]) {
            if (entitie.containsKey(assistant.id)) {
              entities.add(entitie);
              LogServices().saveMetric(
                apiKey,
                Metric(
                  assistantId: assistant.id,
                  evaluationVersion: "Package 0.0.7",
                  inputValue: transcript,
                  outputValue: entitie[assistant.id],
                  seconds: entitie["seconds"],
                ),
              );
            }
          }
        }
      } else {
        throw Exception('Failed to load transcript: ${response.statusCode}');
      }
    } catch (e) {
      print("Error occurred: $e"); // Log de depuração
    }

    return entities;
  }

  Future<List<Assistant>> getAssistants(String apiKey) async {
    List<Assistant> assistants = [];
    try {
      // Construir o corpo da requisição JSON
      var requestBody = {
        'service_name': 'get_assistants',
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
        var body = Map<String, dynamic>.from(jsonDecode(response.body));
        for (var i = 0; i < body["assistants"].length; i++) {
          assistants.add(Assistant.fromJson(body["assistants"][i]));
        }
        print(body);
      } else {
        throw Exception('Failed to load transcript: ${response.statusCode}');
      }
    } catch (e) {
      print("Error occurred: $e"); // Log de depuração
    }
    return assistants;
  }

  Future<Map<String, dynamic>> getTranscript(
      File? file, String language, String apiKey) async {
    if (file == null) {
      throw Exception("File is null");
    }

    var request = http.MultipartRequest('POST',
        Uri.parse('https://care-voice-ai.azurewebsites.net/process_audio'));

    // var request = http.MultipartRequest(
    //     'POST', Uri.parse('http://127.0.0.1:5000/process_audio'));

    request.fields.addAll({
      'service_name': 'speech_to_text',
      'language': language,
      'api_key': apiKey,
      'platform': Platform.isAndroid ? "ANDROID" : "IOS",
      'encode': Platform.isAndroid ? "OPUS" : "FLAC",
      'extract_entities': "true",
      'url': ''
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
      // print(await response.stream.bytesToString());
      // Verificar o status da resposta
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print("---------------------------------");
        print(" Response received successfully. "); // Log de depuração
        print(responseData);
        print("---------------------------------");
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
