class MedicalCard {
  final String age;
  final String birth;
  final String id;
  final String phoneNumber;
  final String address;
  final String weight;
  final String dateOfDiseaseOnset;
  final String performedOperations;
  final String performedProcedures;
  final String bloodType;
  final String diagnosis;
  final String diseaseSeverity;
  final String allergies;
  final String user;
  final String userName;

  MedicalCard({
    required this.userName,
    required this.id,
    required this.age,
    required this.birth,
    required this.phoneNumber,
    required this.address,
    required this.weight,
    required this.dateOfDiseaseOnset,
    required this.performedOperations,
    required this.performedProcedures,
    required this.bloodType,
    required this.diagnosis,
    required this.diseaseSeverity,
    required this.allergies,
    required this.user,
  });

  factory MedicalCard.fromJson(Map<String, dynamic> json) {
    return MedicalCard(
      age: json['age'],
      birth: json['birth'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      weight: json['weight'],
      dateOfDiseaseOnset: json['dateOfDiseaseOnset'],
      performedOperations: json['performedOperations'],
      performedProcedures: json['performedProcedures'],
      bloodType: json['bloodType'],
      diagnosis: json['diagnosis'],
      id: json['_id'],
      diseaseSeverity: json['diseaseSeverity'],
      allergies: json['allergies'],
      user: json['user']['_id'],
      userName: json['user']['fullName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'birth': birth,
      'phoneNumber': phoneNumber,
      'address': address,
      'weight': weight,
      'dateOfDiseaseOnset': dateOfDiseaseOnset,
      'performedOperations': performedOperations,
      'performedProcedures': performedProcedures,
      'bloodType': bloodType,
      'diagnosis': diagnosis,
      '_id': id,
      'diseaseSeverity': diseaseSeverity,
      'allergies': allergies,
      'user': {
        '_id': user,
        'fullName': userName,
      },
    };
  }
}
