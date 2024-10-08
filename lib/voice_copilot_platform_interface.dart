import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:voice_copilot/models/assistants/main.dart';
import 'package:voice_copilot/voice_copilot_method_channel.dart'; // Corrigido o import

abstract class VoiceCopilotPlatform extends PlatformInterface {
  VoiceCopilotPlatform() : super(token: _token);

  static final Object _token = Object();

  static VoiceCopilotPlatform _instance = LocalVoiceCopilot(); // Corrigido

  static VoiceCopilotPlatform get instance => _instance;

  static set instance(VoiceCopilotPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> startRecord(Map<String, dynamic>? params) {
    throw UnimplementedError('startRecord() has not been implemented.');
  }

  Future<Map<String, dynamic>> stopRecord(String apiKey, String language) {
    throw UnimplementedError('stopRecord() has not been implemented.');
  }

  Future<List<Assistant>> getAssistants(String apiKey) {
    throw UnimplementedError('stopRecord() has not been implemented.');
  }

  Future<List<Map<String, dynamic>>> useAssistants(
      String apiKey, List<Assistant> assistants, String transcript) {
    throw UnimplementedError('stopRecord() has not been implemented.');
  }

  Future<bool> cancelAudio() {
    throw UnimplementedError('stopRecord() has not been implemented.');
  }

  Future<bool> startCalibration(
      String baseTextTranscript, String? languageChange) {
    throw UnimplementedError('startCalibration() has not been implemented.');
  }

  Future<Map<String, dynamic>> stopCalibration(
    String apiKey,
  ) {
    throw UnimplementedError('stopCalibration() has not been implemented.');
  }
}
