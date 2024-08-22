import 'package:voice_copilot/models/assistants/main.dart';
import 'package:voice_copilot/services/api/main.dart';

class AssistantService {
  String baseText = "";
  String language = "pt";

  Future<List<Assistant>> getAssistants(String apiKey) async {
    return await ApiService().getAssistants(apiKey);
  }

  Future<List<Map<String, dynamic>>> useAssistants(
      String apiKey, List<Assistant> assistants, String transcript) async {
    return await ApiService().useAssistants(apiKey, assistants, transcript);
  }
}
