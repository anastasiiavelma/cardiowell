class Post {
  final String title;
  final String textInfo;
  final String user;
  final String id;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post({
    required this.title,
    required this.imageUrl,
    required this.textInfo,
    required this.user,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] as Map<String, dynamic>;

    return Post(
      title: json['title'],
      textInfo: json['textInfo'],
      imageUrl: json['imageUrl'],
      user: userJson['_id'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
