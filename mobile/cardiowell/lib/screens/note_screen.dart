import 'package:cardiowell/models/note.dart';
import 'package:cardiowell/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class NotesScreen extends StatefulWidget {
  final String userId;

  const NotesScreen({super.key, required this.userId});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    try {
      final List<Note> fetchedNotes = await fetchUserNotes(widget.userId);
      setState(() {
        notes = fetchedNotes;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your notes",
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: HexColor("#4f4f4f"),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Container(
            decoration: BoxDecoration(
              color: HexColor("#f0f3f1"),
              borderRadius: BorderRadius.circular(25.0),
            ),
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(note.textInfo),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(DateFormat('MM-dd-yyyy').format(note.createdAt),
                      style: TextStyle(
                          color: HexColor("#ff6700"),
                          fontWeight: FontWeight.bold)),
                  Text('Oxygen Level: ${note.oxygenLevel}',
                      style: TextStyle(color: HexColor("#4f4f4f"))),
                  Text('Pulse: ${note.pulse}',
                      style: TextStyle(color: HexColor("#4f4f4f"))),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your desired functionality here
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
}
