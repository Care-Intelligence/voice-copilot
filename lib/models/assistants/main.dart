class Assistant {
  String id;
  String key;

  Assistant({required this.id, required this.key});

  factory Assistant.fromJson(Map<String, dynamic> json) {
    return Assistant(
      id: json['id'],
      key: json['key'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
    };
  }
}
