import 'package:cardiowell/models/note.dart';
import 'package:cardiowell/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uuid/uuid.dart';

class NoteScreenDetail extends StatefulWidget {
  final String userId;
  final bool isUpdate;
  final Note? note;
  final String token;
  const NoteScreenDetail(
      {Key? key,
      required this.isUpdate,
      this.note,
      required this.userId,
      required this.token})
      : super(key: key);

  @override
  _NoteScreenDetailState createState() => _NoteScreenDetailState();
}

class _NoteScreenDetailState extends State<NoteScreenDetail> {
  TextEditingController title = TextEditingController();
  TextEditingController textInfo = TextEditingController();
  TextEditingController pulse = TextEditingController();
  TextEditingController bloodPressure = TextEditingController();
  TextEditingController oxygenLevel = TextEditingController();
  TextEditingController idUser = TextEditingController();
  FocusNode noteFocus = FocusNode(); // Declare the noteFocus variable

  Future<void> addNewNote() async {
    print(widget.userId);
    final userId = widget.userId;
    Note newNote = Note(
      title: title.text,
      pulse: pulse.text,
      bloodPressure: bloodPressure.text,
      oxygenLevel: oxygenLevel.text,
      textInfo: textInfo.text,
      id: const Uuid().v1(),
      createdAt: DateTime.now(),
      user: userId,
      updatedAt: DateTime.now(),
    );

    try {
      await addNote(newNote, userId, widget.token);
      // Note added successfully
      print('Note added successfully');
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      // Failed to add note
      print('Failed to add note: $e');
      // Handle the error or show an error message
    }
  }

  Future<void> updateNote() async {
    if (widget.note == null) return;

    Note updatedNote = Note(
      title: title.text,
      pulse: pulse.text,
      bloodPressure: bloodPressure.text,
      oxygenLevel: oxygenLevel.text,
      textInfo: textInfo.text,
      user: widget.userId,
      id: widget.note!.id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      await updatesNote(widget.note!.id, updatedNote, widget.userId);
      // Note updated successfully
      print('Note updated successfully');
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      // Failed to update note
      print('Failed to update note: $e');
      // Handle the error or show an error message
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.isUpdate && widget.note != null) {
      title.text = widget.note!.title;
      textInfo.text = widget.note!.textInfo;
      pulse.text = widget.note!.pulse;
      bloodPressure.text = widget.note!.bloodPressure;
      oxygenLevel.text = widget.note!.oxygenLevel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isUpdate ? 'Update note' : 'Add note',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: HexColor("#4f4f4f"),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (widget.isUpdate) {
                updateNote();
              } else {
                addNewNote();
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    controller: title,
                    autofocus: (widget.isUpdate == true) ? false : true,
                    onSubmitted: (val) {
                      if (val != "") {
                        FocusScope.of(context).requestFocus(noteFocus);
                      }
                    },
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Title",
                      border: InputBorder.none,
                    ),
                  ),
                  TextField(
                    controller: pulse,
                    maxLines: null,
                    style: const TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.heart_broken,
                        size: 20,
                        color: HexColor("#ff6700"),
                      ),
                      hintText: "pulse",
                      border: InputBorder.none,
                    ),
                  ),
                  TextField(
                    controller: bloodPressure,
                    maxLines: null,
                    style: const TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.opacity,
                        size: 20,
                        color: HexColor("#ff6700"),
                      ),
                      hintText: "bloodPressure",
                      border: InputBorder.none,
                    ),
                  ),
                  TextField(
                    controller: oxygenLevel,
                    maxLines: null,
                    style: const TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.cloud,
                        size: 20,
                        color: HexColor("#ff6700"),
                      ),
                      hintText: "oxygenLevel",
                      border: InputBorder.none,
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: textInfo,
                      maxLines: null,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        hintText: "Enter note...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
