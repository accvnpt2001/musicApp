// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:musicapp/models/album.dart';
import 'package:musicapp/models/artist.dart';

class Track {
  int id;
  String title;
  String link;
  String preview;
  Artist artist;
  Album? album;
  Track({
    required this.id,
    required this.title,
    required this.link,
    required this.preview,
    required this.artist,
    required this.album,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'link': link,
      'preview': preview,
      'artist': artist.toMap(),
      'album': album?.toMap(),
    };
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
        id: map['id'] ?? "",
        title: map['title'] ?? "",
        link: map['link'] ?? "",
        preview: map['preview'] ?? "",
        artist: Artist.fromMap(map['artist'] as Map<String, dynamic>),
        album: Album.fromMap(map['album'] as Map<String, dynamic>));
  }

  String toJson() => json.encode(toMap());

  factory Track.fromJson(String source) =>
      Track.fromMap(json.decode(source) as Map<String, dynamic>);
}
