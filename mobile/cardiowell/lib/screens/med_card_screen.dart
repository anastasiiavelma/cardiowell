import 'package:cardiowell/models/med_cards.dart';
import 'package:cardiowell/screens/med_card_detail.dart';
import 'package:cardiowell/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class MedCardScreen extends StatefulWidget {
  final String userId;

  const MedCardScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _MedCardScreenState createState() => _MedCardScreenState();
}

class _MedCardScreenState extends State<MedCardScreen> {
  List<MedicalCard> cards = [];

  @override
  void initState() {
    super.initState();
    fetchCards();
  }

  Future<void> fetchCards() async {
    try {
      final List<MedicalCard> fetchedCards =
          await fetchUserMedCards(widget.userId);
      setState(() {
        cards = fetchedCards;
      });
    } catch (error) {
      print(error);
    }
  }

// ignore: non_constant_identifier_names
  void NavigateToCreateScreen() {
    // Add void return type
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedCardScreenDetail(
          isUpdate: false,
          userId: widget.userId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your medical card",
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: HexColor("#4f4f4f"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/doctor3.gif',
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ),
            if (cards.isNotEmpty)
              ...cards.map((card) => _buildCardWidget(card)).toList(),
            if (cards.isEmpty)
              const Center(child: Text('No medical card found.')),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigateToCreateScreen();
        },
        backgroundColor: HexColor("#ff6700"),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCardWidget(MedicalCard card) {
    return Card(
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
            Text(
              'Your Name',
              style: TextStyle(
                fontSize: 16,
                color: HexColor("#ff6700"),
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  card.userName,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const Icon(
                  Icons.person,
                  color: Colors.transparent,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              'Birth',
              style: TextStyle(
                fontSize: 16,
                color: HexColor("#4f4f4f"),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              card.birth,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 16,
                color: HexColor("#4f4f4f"),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              card.phoneNumber,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Address',
              style: TextStyle(
                fontSize: 16,
                color: HexColor("#4f4f4f"),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              card.address,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Weight',
              style: TextStyle(
                fontSize: 16,
                color: HexColor("#4f4f4f"),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              card.weight,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Date of disease onset',
              style: TextStyle(
                fontSize: 16,
                color: HexColor("#4f4f4f"),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              card.dateOfDiseaseOnset,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Performed operations',
              style: TextStyle(
                fontSize: 16,
                color: HexColor("#4f4f4f"),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              card.performedOperations,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Performed procedures',
              style: TextStyle(
                fontSize: 16,
                color: HexColor("#4f4f4f"),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              card.performedProcedures,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Blood type',
              style: TextStyle(
                fontSize: 16,
                color: HexColor("#4f4f4f"),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              card.bloodType,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Diagnosis',
              style: TextStyle(
                fontSize: 16,
                color: HexColor("#4f4f4f"),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              card.diagnosis,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Disease severity',
              style: TextStyle(
                fontSize: 16,
                color: HexColor("#4f4f4f"),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              card.diseaseSeverity,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Allergies',
              style: TextStyle(
                fontSize: 16,
                color: HexColor("#4f4f4f"),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              card.allergies,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
