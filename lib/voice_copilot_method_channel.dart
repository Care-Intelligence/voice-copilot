import 'package:record/record.dart';

import 'voice_copilot_platform_interface.dart';
import 'package:voice_copilot/services/record.dart';

class LocalVoiceCopilot extends VoiceCopilotPlatform {
  final RecordService _processService =
      RecordService(recorder: AudioRecorder());

  @override
  Future<bool> startRecord(Map<String, dynamic> params) async {
    return _processService.startRecord({});
  }

  @override
  Future<Map<String, dynamic>> stopRecord(
      String apiKey, String language) async {
    return _processService.stopRecord(apiKey, language);
  }
}
