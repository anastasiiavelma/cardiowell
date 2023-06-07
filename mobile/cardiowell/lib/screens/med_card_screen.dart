import 'dart:async';
import 'dart:io';
import 'package:cardiowell/models/med_cards.dart';
import 'package:cardiowell/screens/med_card_detail.dart';
import 'package:cardiowell/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class MedCardScreen extends StatefulWidget {
  final String userId;
  final String token;
  const MedCardScreen({super.key, required this.userId, required this.token});

  @override
  _MedCardScreenState createState() => _MedCardScreenState();
}

class _MedCardScreenState extends State<MedCardScreen> {
  List<MedicalCard> cards = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchCards();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => fetchCards());
  }

  @override
  void dispose() {
    // Cancel the timer when the screen is disposed to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

  Future<void> saveAsPDF() async {
    final pdf = pw.Document();

    for (final card in cards) {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Text(
                  'HELLO, ${card.userName}, it`s your med-cards',
                  style: pw.TextStyle(
                      fontSize: 40, fontWeight: pw.FontWeight.bold),
                ),
              ),
              _buildTextWithLabel('Age:', card.age),
              _buildTextWithLabel('Birth:', card.birth),
              _buildTextWithLabel('Weight:', card.weight),
              _buildTextWithLabel('Phone Number:', card.phoneNumber),
              _buildTextWithLabel(
                  'Date of Disease Onset:', card.dateOfDiseaseOnset),
              _buildTextWithLabel(
                  'Performed Operations:', card.performedOperations),
              _buildTextWithLabel('Address:', card.address),
              _buildTextWithLabel('Blood Type:', card.bloodType),
              _buildTextWithLabel('Diagnosis:', card.diagnosis),
              _buildTextWithLabel('Disease Severity:', card.diseaseSeverity),
              _buildTextWithLabel('Allergies:', card.allergies),
            ]); // Center
          }));
    }

    final directory =
        (await getExternalStorageDirectories(type: StorageDirectory.downloads))!
            .first;

    File file = File("${directory.path}/med-card.pdf");
    await file.writeAsBytes(await pdf.save());
    print('PDF сохранен по пути: $file');
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

  void _deleteNoteAtIndex(int index) async {
    final card = cards[index];
    try {
      await deleteCard(card.id);
      setState(() {
        cards.removeAt(index);
      });
    } catch (error) {
      print(error);
    }
  }

  void NavigateToCreateScreen() {
    // Add void return type
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedCardScreenDetail(
          userId: widget.userId,
          token: widget.token,
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
        actions: [
          IconButton(
            onPressed: () {
              saveAsPDF().then((_) {
                // Показываем всплывающее окно об успешности
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('PDF успешно сохранен'),
                  ),
                );
              }).catchError((error) {
                // Обработка ошибок при сохранении PDF-файла
                print('Ошибка при сохранении PDF: $error');
              });
            },
            icon: const Icon(Icons.file_upload),
          ),
        ],
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          _deleteNoteAtIndex(index);
                        }
                      },
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20.0),
                        color: HexColor("#ff6700"),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child:
                          SingleChildScrollView(child: buildCardWidget(card)));
                },
              ),
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
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildCardWidget(MedicalCard card) {
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
                  card.userName!,
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
              'Age',
              style: TextStyle(
                fontSize: 16,
                color: HexColor("#4f4f4f"),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              card.age,
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

  pw.Widget _buildTextWithLabel(String label, String text) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            text,
            style: const pw.TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  }
}
