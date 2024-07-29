library voice_copilot;

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
