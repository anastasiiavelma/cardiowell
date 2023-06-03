class MedicalCard {
  final String age;
  final String birth;
  final String phoneNumber;
  final String address;
  final String weight;
  final String dateOfDiseaseOnset;
  final String performedOperations;
  final String performedProcedures;
  List<MedicalPreparation>? medicalPreparations;
  final String bloodType;
  final String diagnosis;
  final String diseaseSeverity;
  final String allergies;
  final String user;
  final String userName;

  MedicalCard({
    required this.age,
    required this.birth,
    required this.phoneNumber,
    required this.address,
    required this.weight,
    required this.dateOfDiseaseOnset,
    required this.performedOperations,
    required this.performedProcedures,
    required this.medicalPreparations,
    required this.bloodType,
    required this.diagnosis,
    required this.diseaseSeverity,
    required this.allergies,
    required this.user,
    required this.userName,
  });

  factory MedicalCard.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? medicalPreparationsJson = json['medicalPreparations'];
    final userJson = json['user'] as Map<String, dynamic>;
    final String name = userJson['fullName'];

    List<MedicalPreparation>? medicalPreparations;
    if (medicalPreparationsJson != null) {
      medicalPreparations = medicalPreparationsJson
          .map((item) => MedicalPreparation.fromJson(item))
          .toList();
    }

    return MedicalCard(
      age: json['age'],
      birth: json['birth'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      weight: json['weight'],
      dateOfDiseaseOnset: json['dateOfDiseaseOnset'],
      performedOperations: json['performedOperations'],
      performedProcedures: json['performedProcedures'],
      medicalPreparations: medicalPreparations,
      bloodType: json['bloodType'],
      diagnosis: json['diagnosis'],
      diseaseSeverity: json['diseaseSeverity'],
      allergies: json['allergies'],
      user: userJson['user'],
      userName: name,
    );
  }
}

class MedicalPreparation {
  final String nameOfMedicine;
  final String dosage;
  final String mode;
  final String durationOfAdmission;
  final String sideEffects;

  MedicalPreparation({
    required this.nameOfMedicine,
    required this.dosage,
    required this.mode,
    required this.durationOfAdmission,
    required this.sideEffects,
  });

  factory MedicalPreparation.fromJson(Map<String, dynamic> json) {
    return MedicalPreparation(
      nameOfMedicine: json['nameOfMedicine'],
      dosage: json['dosage'],
      mode: json['mode'],
      durationOfAdmission: json['durationOfAdmission'],
      sideEffects: json['sideEffects'],
    );
  }
}
