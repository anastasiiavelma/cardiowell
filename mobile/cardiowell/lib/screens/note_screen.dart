import 'dart:async';

import 'package:cardiowell/models/note.dart';
import 'package:cardiowell/screens/note_detail_screen.dart';
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
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchNotes();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => fetchNotes());
  }

  @override
  void dispose() {
    // Cancel the timer when the screen is disposed to avoid memory leaks
    _timer.cancel();
    super.dispose();
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

  void _deleteNoteAtIndex(int index) {
    final note = notes[index];
    deleteNote(note.id).then((_) {
      setState(() {
        notes.removeAt(index);
      });
    }).then((_) {
      fetchNotes(); // Fetch notes after the deletion is completed
    });
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
          // final note = notes[index];
          final note = notes.reversed.toList()[index];
          return Dismissible(
            key: Key(note.id), // Use a unique key for each note
            direction: DismissDirection.endToStart, // Swipe direction
            background: Container(
              color: HexColor("#ff6700"),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              _deleteNoteAtIndex(index);
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteScreenDetail(
                      isUpdate: true,
                      note: note,
                      userId: note.user,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor("#f0f3f1"),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                padding: const EdgeInsets.all(8.0),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.textInfo),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(DateFormat('MM-dd-yyyy').format(note.createdAt!),
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
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteScreenDetail(
                isUpdate: false,
                userId: widget.userId,
              ),
            ),
          );
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
