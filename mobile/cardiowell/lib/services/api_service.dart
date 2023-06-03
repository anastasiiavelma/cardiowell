import 'package:cardiowell/models/note.dart';
import 'package:cardiowell/models/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Note>> fetchUserNotes(String userId) async {
  final url = Uri.parse('http://10.0.2.2:5000/notes?user=$userId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print(response.body);
    final List<dynamic> data = jsonDecode(response.body);
    final List<Note> notes = data.map((json) => Note.fromJson(json)).toList();
    return notes;
  } else {
    throw Exception('Failed to fetch user notes');
  }
}

Future<List<Post>> fetchPosts() async {
  final url = Uri.parse('http://10.0.2.2:5000/posts');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print(response.body);
    final List<dynamic> data = jsonDecode(response.body);
    final List<Post> posts = data.map((json) => Post.fromJson(json)).toList();
    return posts;
  } else {
    throw Exception('Failed to post');
  }
}
