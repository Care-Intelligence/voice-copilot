import 'dart:io';

import 'package:record/record.dart';
import 'package:voice_copilot/models/transcript/main.dart';
import 'package:voice_copilot/services/record.dart';

class CalibrationService {
  final AudioRecorder recorder;
  final TranscriptService _service = TranscriptService();
  String baseText = "";
  String language = "pt";

  CalibrationService({required this.recorder});

  Future<bool> startCalibration(
      String baseTextTranscript, String? languageChange) async {
    // if (baseText.isEmpty) return false;
    // recorder.hasPermission();

    // if (baseText == "") return false;
    baseText = baseTextTranscript;
    language = languageChange ?? "pt";
    return await RecordService(recorder: recorder).startRecord({});
  }

  Future<Map<String, dynamic>> stopCalibration(
    String apiKey,
  ) async {
    recorder.hasPermission();
    Map<String, dynamic> resultStopRecord = {
      'status': false,
      'content': null,
      'percent_result': 0,
    };

    try {
      Map<String, dynamic> transcript =
          await RecordService(recorder: recorder).stopRecord(apiKey, language);
      if (transcript["status"] == false) return transcript;

      Map<String, dynamic> speechToTextResult =
          await _service.getEncoder(apiKey, transcript['transcript'], baseText);
      print(speechToTextResult);

      if (speechToTextResult["status"]) {
        return speechToTextResult;
      }

      return resultStopRecord;
    } catch (e) {
      return resultStopRecord;
    }
  }
}
