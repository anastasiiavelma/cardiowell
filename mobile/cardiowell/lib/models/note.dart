class Note {
  String title;
  String pulse;
  String bloodPressure;
  String oxygenLevel;
  String textInfo;
  String user;
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;

  Note({
    required this.title,
    required this.pulse,
    required this.bloodPressure,
    required this.oxygenLevel,
    required this.textInfo,
    required this.user,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
        title: json['title'],
        pulse: json['pulse'],
        bloodPressure: json['bloodPressure'],
        oxygenLevel: json['oxygenLevel'],
        textInfo: json['textInfo'],
        user: json['user']['_id'],
        id: json['_id'],
        createdAt: DateTime.tryParse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']));
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'pulse': pulse,
      'bloodPressure': bloodPressure,
      'oxygenLevel': oxygenLevel,
      'textInfo': textInfo,
      'user': user,
      '_id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
