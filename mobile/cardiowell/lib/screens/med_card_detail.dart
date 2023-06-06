import 'dart:async';

import 'package:cardiowell/models/med_cards.dart';
import 'package:cardiowell/services/api_service.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uuid/uuid.dart';

class MedCardScreenDetail extends StatefulWidget {
  final String userId;
  final MedicalCard? medCard;
  const MedCardScreenDetail({Key? key, this.medCard, required this.userId})
      : super(key: key);

  @override
  _MedCardScreenDetailState createState() => _MedCardScreenDetailState();
}

class _MedCardScreenDetailState extends State<MedCardScreenDetail> {
  TextEditingController age = TextEditingController();
  TextEditingController birth = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController dateOfDiseaseOnset = TextEditingController();
  TextEditingController performedOperations = TextEditingController();
  TextEditingController bloodType = TextEditingController();
  TextEditingController diagnosis = TextEditingController();
  TextEditingController diseaseSeverity = TextEditingController();
  TextEditingController allergies = TextEditingController();
  FocusNode noteFocus = FocusNode();

  Future<void> addNewCard() async {
    print(widget.userId);
    final userId = widget.userId;
    MedicalCard newCard = MedicalCard(
      age: age.text,
      birth: birth.text,
      phoneNumber: phoneNumber.text,
      weight: weight.text,
      address: address.text,
      dateOfDiseaseOnset: dateOfDiseaseOnset.text,
      performedOperations: performedOperations.text,
      bloodType: bloodType.text,
      diagnosis: diagnosis.text,
      diseaseSeverity: diseaseSeverity.text,
      allergies: allergies.text,
      id: const Uuid().v1(),
      createdAt: DateTime.now(),
      user: userId,
      updatedAt: DateTime.now(),
      userName: widget.medCard?.userName ?? '',
      performedProcedures: performedOperations.text,
    );

    try {
      await addMedCards(newCard, userId);
      // Note added successfully
      print('newCard added successfully');
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      // Failed to add note
      print('Failed to add newCard: $e');
      // Handle the error or show an error message
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.medCard != null) {
      age.text = widget.medCard!.age;
      birth.text = widget.medCard!.birth;
      weight.text = widget.medCard!.weight;
      phoneNumber.text = widget.medCard!.phoneNumber;
      dateOfDiseaseOnset.text = widget.medCard!.dateOfDiseaseOnset;
      performedOperations.text = widget.medCard!.performedOperations;
      address.text = widget.medCard!.address;
      bloodType.text = widget.medCard!.bloodType;
      diagnosis.text = widget.medCard!.diagnosis;
      diseaseSeverity.text = widget.medCard!.diseaseSeverity;
      allergies.text = widget.medCard!.allergies;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add card',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: HexColor("#4f4f4f"),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              addNewCard();
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Card(
              shadowColor: HexColor("#000000"),
              surfaceTintColor: HexColor("#8d8d8d"),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: age,
                      onSubmitted: (val) {
                        if (val != "") {
                          FocusScope.of(context).requestFocus(noteFocus);
                        }
                      },
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: "Age",
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.person,
                          size: 20,
                          color: HexColor("#ff6700"),
                        ),
                      ),
                    ),
                    TextField(
                      controller: weight,
                      maxLines: null,
                      style: const TextStyle(fontSize: 17),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.hourglass_bottom,
                          size: 20,
                          color: HexColor("#ff6700"),
                        ),
                        hintText: "weight",
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: birth,
                      maxLines: null,
                      style: const TextStyle(fontSize: 17),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.cake,
                          size: 20,
                          color: HexColor("#ff6700"),
                        ),
                        hintText: "birth",
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: phoneNumber,
                      maxLines: null,
                      style: const TextStyle(fontSize: 17),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.local_phone,
                          size: 20,
                          color: HexColor("#ff6700"),
                        ),
                        hintText: "phoneNumber",
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: dateOfDiseaseOnset,
                      maxLines: null,
                      style: const TextStyle(fontSize: 17),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.date_range,
                          size: 20,
                          color: HexColor("#ff6700"),
                        ),
                        hintText: "dateOfDiseaseOnset",
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: performedOperations,
                      maxLines: null,
                      style: const TextStyle(fontSize: 17),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.local_hospital,
                          size: 20,
                          color: HexColor("#ff6700"),
                        ),
                        hintText: "performedOperations",
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: bloodType,
                      maxLines: null,
                      style: const TextStyle(fontSize: 17),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.opacity,
                          size: 20,
                          color: HexColor("#ff6700"),
                        ),
                        hintText: "blood type",
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: allergies,
                      maxLines: null,
                      style: const TextStyle(fontSize: 17),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.pets,
                          size: 20,
                          color: HexColor("#ff6700"),
                        ),
                        hintText: "allergies",
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: diagnosis,
                      maxLines: null,
                      style: const TextStyle(fontSize: 17),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.gavel,
                          size: 20,
                          color: HexColor("#ff6700"),
                        ),
                        hintText: "diagnosis",
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: diseaseSeverity,
                      maxLines: null,
                      style: const TextStyle(fontSize: 17),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.spa,
                          size: 20,
                          color: HexColor("#ff6700"),
                        ),
                        hintText: "diseaseSeverity",
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: address,
                      maxLines: null,
                      style: const TextStyle(fontSize: 17),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.spa,
                          size: 20,
                          color: HexColor("#ff6700"),
                        ),
                        hintText: "address",
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
