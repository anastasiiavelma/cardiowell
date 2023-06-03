class Note {
  final String title;
  final String pulse;
  final String bloodPressure;
  final String oxygenLevel;
  final String textInfo;
  final String user;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

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
    final userJson = json['user'] as Map<String, dynamic>;

    return Note(
      title: json['title'],
      pulse: json['pulse'],
      bloodPressure: json['bloodPressure'],
      oxygenLevel: json['oxygenLevel'],
      textInfo: json['textInfo'],
      user: userJson['_id'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
