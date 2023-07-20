import 'dart:convert';

class Album {
  int id;
  String title;
  String cover_medium;
  String tracklist;
  Album({
    required this.id,
    required this.title,
    required this.cover_medium,
    required this.tracklist,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'cover_medium': cover_medium,
      'tracklist': tracklist,
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      id: map['id'] as int,
      title: map['title'] as String,
      cover_medium: map['cover_medium'] != null ? map['cover_medium'] as String : '',
      tracklist: map['tracklist'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Album.fromJson(String source) => Album.fromMap(json.decode(source) as Map<String, dynamic>);
}
