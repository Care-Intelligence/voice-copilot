class Metric {
  String assistantId;
  int seconds;
  String evaluationVersion;
  String inputValue;
  Map<String, dynamic> outputValue;

  Metric({
    required this.assistantId,
    required this.evaluationVersion,
    required this.inputValue,
    required this.outputValue,
    required this.seconds,
  });

  factory Metric.fromJson(Map<String, dynamic> json) {
    return Metric(
      assistantId: json["id"],
      seconds: json["seconds"],
      evaluationVersion: json["evaluationVersion"],
      inputValue: json["inputValue"],
      outputValue: json["outputValue"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assistant_id': assistantId,
      'seconds': seconds,
      'evaluation_version': evaluationVersion,
      'input_value': inputValue,
      'output_value': outputValue,
    };
  }
}
