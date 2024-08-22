import 'package:voice_copilot/models/metrics/main.dart';
import 'package:voice_copilot/services/api/main.dart';

class LogServices {
  Future<bool> saveMetric(String apiKey, Metric args) async {
    return await ApiService().saveMetric(apiKey, args);
  }
}
