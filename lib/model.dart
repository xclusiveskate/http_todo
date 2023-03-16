import 'dart:convert';

class Album {
  final int id;
  final int userId;
  final String title;
  final bool isCompleted;
  Album({
    required this.id,
    required this.userId,
    required this.title,
    required this.isCompleted,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }

  // factory Album.fromJson(String source) => Album.fromJson(json.decode(source));

  // @override
  // String toString() {
  //   return 'Album(id: $id, userId: $userId, title: $title, isCompleted: $isCompleted)';
  // }

  // Map<String, dynamic> toMap() {
  //   final result = <String, dynamic>{};

  //   result.addAll({'id': id});
  //   result.addAll({'userId': userId});
  //   result.addAll({'title': title});
  //   result.addAll({'isCompleted': isCompleted});

  //   return result;
  // }

  // String toJson() => json.encode(toMap());
}
