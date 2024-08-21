library voice_copilot;

import 'package:voice_copilot/models/assistants/main.dart';
import 'package:voice_copilot/voice_copilot_platform_interface.dart';

class CareVoiceCopilot {
  final String language;
  final String apiKey;

  CareVoiceCopilot({required this.language, required this.apiKey});

  Future<bool> start(Map<String, dynamic>? calibration) async {
    return await VoiceCopilotPlatform.instance.startRecord(calibration);
  }

  Future<Map<String, dynamic>> stop() async {
    return VoiceCopilotPlatform.instance.stopRecord(apiKey, language);
  }

  Future<List<Assistant>> getAssistants() async {
    return await VoiceCopilotPlatform.instance.getAssistants(apiKey);
  }

  Future<List<Map<String, dynamic>>> useAssistants(
      List<Assistant> assistants, String transcript) async {
    return await VoiceCopilotPlatform.instance
        .useAssistants(apiKey, assistants, transcript);
  }

  Future<bool> cancelAudio() async {
    return VoiceCopilotPlatform.instance.cancelAudio();
  }

  Future<bool> startCalibration(
    String baseTextTranscript,
  ) async {
    return VoiceCopilotPlatform.instance
        .startCalibration(baseTextTranscript, language);
  }

  Future<Map<String, dynamic>> stopCalibration() async {
    return VoiceCopilotPlatform.instance.stopCalibration(apiKey);
  }
}
