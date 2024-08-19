import 'dart:io';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voice_copilot/models/transcript/main.dart';
import 'package:voice_copilot/services/encoder/main.dart';

class RecordService {
  final AudioRecorder recorder;
  final TranscriptService _service = TranscriptService();

  RecordService({required this.recorder});

  Future<bool> startRecord(Map<String, dynamic>? userCalibrationData) async {
    await recorder.hasPermission();
    try {
      RecordConfig defaultRecordConfig = EncoderService().getRecordConfig()[0];
      if (userCalibrationData != null) {
        if (userCalibrationData['recordConfig'] != null) {
          defaultRecordConfig = userCalibrationData['recordConfig'];
        }
      }

      if (Platform.isAndroid) {
        recorder.start(defaultRecordConfig,
            path:
                '/storage/emulated/0/Download/${DateTime.now().microsecondsSinceEpoch.toString()}.m4a');
      } else {
        final Directory tempDir = await getTemporaryDirectory();
        final String tempPath = tempDir.path;

        recorder.start(defaultRecordConfig,
            path:
                '$tempPath/${DateTime.now().microsecondsSinceEpoch.toString()}.m4a');
      }
      // Atualize o estado de gravação para true após iniciar a gravação
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map<String, dynamic>> stopRecord(
    String apiKey,
    String language,
  ) async {
    recorder.hasPermission();
    Map<String, dynamic> resultStopRecord = {
      'status': false,
      'transcript': 'Não detectou nada...',
      'entities': [],
      'input_tokens': 0,
      'output_tokens': 0,
      'url': ''
    };

    try {
      final path = await recorder.stop();
      File? audioFile = File(path!);

      Map speechToTextResult =
          await _service.getTranscript(audioFile, language, apiKey);
      bool isSuccess = speechToTextResult['transcript'].toString().isNotEmpty;

      if (isSuccess) {
        resultStopRecord['transcript'] = speechToTextResult['transcript'];
        resultStopRecord['entities'] = speechToTextResult['entities'];
        resultStopRecord['input_tokens'] = speechToTextResult['input_tokens'];
        resultStopRecord['output_tokens'] = speechToTextResult['output_tokens'];
        resultStopRecord['url'] = speechToTextResult['url'];
        resultStopRecord['status'] = true;
        print(resultStopRecord);
        return resultStopRecord;
      }

      return resultStopRecord;
    } catch (e) {
      return resultStopRecord;
    }
  }

  Future<bool> cancelAudio() async {
    final path = await recorder.stop();
    if (path != null) {
      return true;
    }
    return false;
  }
}
