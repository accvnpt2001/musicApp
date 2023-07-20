import 'dart:convert';

class Artist {
  int id;
  String name;
  String picture;
  String pictureBig;
  String tracklist;
  Artist({
    required this.id,
    required this.name,
    required this.picture,
    required this.pictureBig,
    required this.tracklist,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'picture': picture,
      'tracklist': tracklist,
      'picture_big': pictureBig,
    };
  }

  factory Artist.fromMap(Map<String, dynamic> map) {
    return Artist(
      id: map['id'] as int,
      name: map['name'] as String,
      picture: map['picture'] != null ? map['picture'] as String : '',
      pictureBig: map['picture_big'] != null ? map['picture_big'] as String : '',
      tracklist: map['tracklist'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Artist.fromJson(String source) => Artist.fromMap(json.decode(source) as Map<String, dynamic>);
}
