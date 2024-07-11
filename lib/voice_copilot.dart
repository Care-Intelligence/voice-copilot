library voice_copilot;

import 'package:voice_copilot/voice_copilot_platform_interface.dart';

class CareVoiceCopilot {
  final String language;
  final String apiKey;

  CareVoiceCopilot({required this.language, required this.apiKey});

  Future<bool> start() async {
    // await _loadEnv();
    return await VoiceCopilotPlatform.instance.startRecord({});
  }

  Future<Map<String, dynamic>> stop() async {
    // await _loadEnv();
    return VoiceCopilotPlatform.instance.stopRecord(apiKey, language);
  }
}
