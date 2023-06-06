import 'package:cardiowell/models/med_cards.dart';
import 'package:cardiowell/models/note.dart';
import 'package:cardiowell/models/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Note>> fetchUserNotes(String user) async {
  final url = Uri.parse('http://10.0.2.2:5000/notes?user=$user');
  final response = await http.get(url);
  //print(response.body);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    final List<Note> notes = data.map((json) => Note.fromJson(json)).toList();

    // Filter the notes by user
    final List<Note> userNotes =
        notes.where((note) => note.user == user).toList();

    return userNotes;
  } else {
    throw Exception('Failed to fetch user notes');
  }
}

Future<List<MedicalCard>> fetchUserMedCards(String user) async {
  final url = Uri.parse('http://10.0.2.2:5000/med-cards/?user=$user');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    final List<MedicalCard> cards =
        data.map((json) => MedicalCard.fromJson(json)).toList();

    final List<MedicalCard> medCards =
        cards.where((cards) => cards.user == user).toList();

    return medCards;
  } else {
    throw Exception('Failed to fetch user card');
  }
}

Future<void> deleteNote(String notesId) async {
  try {
    final response = await http.delete(
      Uri.parse('http://10.0.2.2:5000/notes/$notesId'),
    );

    if (response.statusCode == 200) {
      debugPrint('Noted deleted');
    } else {
      debugPrint('Failed to delete note: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error occurred while deleting note: $e');
  }
}

Future<void> deleteCard(String cardId) async {
  try {
    final response = await http.delete(
      Uri.parse('http://10.0.2.2:5000/med-cards/$cardId'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      debugPrint('card deleted');
    } else {
      debugPrint('Failed to delete card: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error occurred while deleting card: $e');
  }
}

Future<List<Post>> fetchPosts() async {
  final url = Uri.parse('http://10.0.2.2:5000/posts');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // print(response.body);
    final List<dynamic> data = jsonDecode(response.body);
    final List<Post> posts = data.map((json) => Post.fromJson(json)).toList();
    return posts;
  } else {
    throw Exception('Failed to post');
  }
}

ImageProvider getImage(String imageName) {
  String imageUrl = 'http://10.0.2.2:5000$imageName';
  ImageProvider imageProvider;
  try {
    imageProvider = NetworkImage(imageUrl);
  } catch (error) {
    imageProvider = const AssetImage('assets/images/default.jpg');
  }

  return imageProvider;
}

Future<void> addNote(Note note, String userId) async {
  String authToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDdjOTQyYzQyNWQ4YmJjNzkxMGMyMjYiLCJpYXQiOjE2ODU5NTYwOTMsImV4cCI6MTY4ODU0ODA5M30.uOXrqTqx5vQBPRliQm46sQCdTcooOp8QabnocG3Mlcg';
  final url = Uri.parse('http://10.0.2.2:5000/notes');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $authToken',
  };

  final body = jsonEncode(note.toJson());

  final response = await http.post(url, headers: headers, body: body);
  print('Response status code: ${response.statusCode}');
  print('Response body: ${response.body}');
  if (response.statusCode == 200) {
    // Note added successfully
    print('Note added successfully');
  } else {
    // Failed to add note
    throw Exception('Failed to add note');
  }
}

Future<void> addMedCards(MedicalCard card, String userId) async {
  String authToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDdjOTQyYzQyNWQ4YmJjNzkxMGMyMjYiLCJpYXQiOjE2ODU5NTYwOTMsImV4cCI6MTY4ODU0ODA5M30.uOXrqTqx5vQBPRliQm46sQCdTcooOp8QabnocG3Mlcg';
  final url = Uri.parse('http://10.0.2.2:5000/med-cards');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $authToken',
  };

  final body = jsonEncode(card.toJson());

  final response = await http.post(url, headers: headers, body: body);
  print('Response status code: ${response.statusCode}');
  print('Response body: ${response.body}');
  if (response.statusCode == 200 && response.statusCode == 201) {
    // Note added successfully
    print('MedCards added successfully');
  } else {
    // Failed to add note
    print('Failed to add card');
  }
}

Future<void> updatesNote(String id, Note note, String userId) async {
  final url = Uri.parse('http://10.0.2.2:5000/notes/$id');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode(note.toJson());

  note.user = userId;

  try {
    final response = await http.patch(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Note updated successfully
      print('Note updated successfully');
    } else {
      throw Exception('Failed to update note');
    }
  } catch (e) {
    print(e);
    throw Exception('Failed to update note');
  }
}
