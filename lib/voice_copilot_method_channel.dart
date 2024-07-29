import 'package:record/record.dart';
import 'package:voice_copilot/services/calibration.dart';

import 'voice_copilot_platform_interface.dart';
import 'package:voice_copilot/services/record.dart';

class LocalVoiceCopilot extends VoiceCopilotPlatform {
  final RecordService _processService =
      RecordService(recorder: AudioRecorder());
  final CalibrationService _calibrationService =
      CalibrationService(recorder: AudioRecorder());
  @override
  Future<bool> startRecord(Map<String, dynamic>? params) async {
    return _processService.startRecord(params);
  }

  @override
  Future<Map<String, dynamic>> stopRecord(
      String apiKey, String language) async {
    return _processService.stopRecord(apiKey, language);
  }

  @override
  Future<bool> startCalibration(
      String baseTextTranscript, String? languageChange) async {
    return _calibrationService.startCalibration(
        baseTextTranscript, languageChange);
  }

  @override
  Future<Map<String, dynamic>> stopCalibration(String apiKey) async {
    return _calibrationService.stopCalibration(apiKey);
  }

  @override
  Future<bool> cancelAudio() async {
    return _processService.cancelAudio();
  }
}
