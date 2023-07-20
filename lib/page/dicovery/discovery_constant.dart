import 'package:musicapp/models/album.dart';
import 'package:musicapp/models/artist.dart';
import 'package:musicapp/models/track_model.dart';

class DiscoveryConstants {
  static List<Track> listTrackRecommend = [
    Track(
      id: 1706822057,
      title: "That's Hilarious",
      link: 'https://www.deezer.com/track/1706822057',
      preview: "https://cdns-preview-f.dzcdn.net/stream/c-f483be229681d72efe34826d4d8b5d2b-3.mp3",
      artist: Artist(
        id: 1362735,
        name: "Charlie Puth",
        picture: "https://imgx.sonora.id/crop/0x0:0x0/700x465/photo/2022/09/02/ajpg-20220902073239.jpg",
        pictureBig: "https://imgx.sonora.id/crop/0x0:0x0/700x465/photo/2022/09/02/ajpg-20220902073239.jpg",
        tracklist: "https://api.deezer.com/artist/1362735/top?limit=50",
      ),
      album: Album(
        id: 307871597,
        title: "That's Hilarious",
        cover_medium:
            "https://e-cdns-images.dzcdn.net/images/cover/734c835b665dfa3e9b50316183bed0c0/250x250-000000-80-0-0.jpg",
        tracklist: "https://api.deezer.com/album/307871597/tracks",
      ),
    ),
    Track(
      id: 2317919965,
      title: "Timber (feat. Ke\$ha)",
      link: "https://www.deezer.com/track/2317919965",
      preview: "https://cdns-preview-9.dzcdn.net/stream/c-95c6cc6902095c76291c4f3e25958154-2.mp3",
      artist: Artist(
        id: 776,
        name: "Pitbull",
        picture: "https://i.ytimg.com/vi/pzeGGTT69A4/maxresdefault.jpg",
        pictureBig:
            "https://e-cdns-images.dzcdn.net/images/artist/f755bcad19948129e670598a52d3f874/500x500-000000-80-0-0.jpg",
        tracklist: "https://api.deezer.com/artist/776/top?limit=50",
      ),
      album: Album(
        id: 450340855,
        title: "Músicas Pop para Malhar | Academia 2023",
        cover_medium:
            "https://e-cdns-images.dzcdn.net/images/cover/5c887b46917dbb2daf7c354c67959520/250x250-000000-80-0-0.jpg",
        tracklist: "https://api.deezer.com/album/450340855/tracks",
      ),
    ),
    Track(
      id: 124995668,
      title: "Side To Side",
      link: "https://www.deezer.com/track/124995668",
      preview: "https://cdns-preview-e.dzcdn.net/stream/c-e2ea533b11d8fd908d263aab96118fe0-7.mp3",
      artist: Artist(
        id: 1562681,
        name: "Ariana Grande",
        picture:
            "https://m.media-amazon.com/images/M/MV5BMTg3NzQzMmYtNWQxNS00NDYzLTgzMTctNmRkOTE2ZjlkYWJhXkEyXkFqcGdeQXVyMjAwMzU2MDY@._V1_.jpg",
        pictureBig:
            "https://e-cdns-images.dzcdn.net/images/artist/3b99aa38bc4f58b05d6671c918eeb03e/500x500-000000-80-0-0.jpg",
        tracklist: "https://api.deezer.com/artist/1562681/top?limit=50",
      ),
      album: Album(
        id: 13139438,
        title: "Dangerous Woman",
        cover_medium:
            "https://e-cdns-images.dzcdn.net/images/cover/e5bf0368c12f211bdafe91deba06cdda/250x250-000000-80-0-0.jpg",
        tracklist: "https://api.deezer.com/album/13139438/tracks",
      ),
    ),
    Track(
      id: 7474206,
      title: "Back To December",
      link: "https://www.deezer.com/track/7474206",
      preview: "https://cdns-preview-1.dzcdn.net/stream/c-17e79183d48441625bfc77b3b4ebd0d1-10.mp3",
      artist: Artist(
        id: 12246,
        name: "Taylor Swift",
        picture: "https://billboardvn.vn/wp-content/uploads/2022/12/2022-12-07-12.42.27-PM.jpg",
        pictureBig:
            "https://e-cdns-images.dzcdn.net/images/artist/8a73d18f63b3c395f7d28da96185478d/500x500-000000-80-0-0.jpg",
        tracklist: "https://api.deezer.com/artist/12246/top?limit=50",
      ),
      album: Album(
        id: 689149,
        title: "Speak Now (Deluxe Package)",
        cover_medium:
            "https://e-cdns-images.dzcdn.net/images/cover/3d4f5060d8c90f084d3433b4e439db6c/250x250-000000-80-0-0.jpg",
        tracklist: "https://api.deezer.com/album/689149/tracks",
      ),
    )
  ];

  static List<Map<String, dynamic>> hotPlaylist = [
    {
      "image": "",
      "name": "",
      "list": [
        Track(
          id: 1706822057,
          title: "That's Hilarious",
          link: 'https://www.deezer.com/track/1706822057',
          preview: "https://cdns-preview-f.dzcdn.net/stream/c-f483be229681d72efe34826d4d8b5d2b-3.mp3",
          artist: Artist(
            id: 1362735,
            name: "Charlie Puth",
            picture: "https://imgx.sonora.id/crop/0x0:0x0/700x465/photo/2022/09/02/ajpg-20220902073239.jpg",
            pictureBig: "https://imgx.sonora.id/crop/0x0:0x0/700x465/photo/2022/09/02/ajpg-20220902073239.jpg",
            tracklist: "https://api.deezer.com/artist/1362735/top?limit=50",
          ),
          album: Album(
            id: 307871597,
            title: "That's Hilarious",
            cover_medium:
                "https://e-cdns-images.dzcdn.net/images/cover/734c835b665dfa3e9b50316183bed0c0/250x250-000000-80-0-0.jpg",
            tracklist: "https://api.deezer.com/album/307871597/tracks",
          ),
        ),
        Track(
          id: 2317919965,
          title: "Timber (feat. Ke\$ha)",
          link: "https://www.deezer.com/track/2317919965",
          preview: "https://cdns-preview-9.dzcdn.net/stream/c-95c6cc6902095c76291c4f3e25958154-2.mp3",
          artist: Artist(
            id: 776,
            name: "Pitbull",
            picture: "https://i.ytimg.com/vi/pzeGGTT69A4/maxresdefault.jpg",
            pictureBig:
                "https://e-cdns-images.dzcdn.net/images/artist/f755bcad19948129e670598a52d3f874/500x500-000000-80-0-0.jpg",
            tracklist: "https://api.deezer.com/artist/776/top?limit=50",
          ),
          album: Album(
            id: 450340855,
            title: "Músicas Pop para Malhar | Academia 2023",
            cover_medium:
                "https://e-cdns-images.dzcdn.net/images/cover/5c887b46917dbb2daf7c354c67959520/250x250-000000-80-0-0.jpg",
            tracklist: "https://api.deezer.com/album/450340855/tracks",
          ),
        ),
        Track(
          id: 124995668,
          title: "Side To Side",
          link: "https://www.deezer.com/track/124995668",
          preview: "https://cdns-preview-e.dzcdn.net/stream/c-e2ea533b11d8fd908d263aab96118fe0-7.mp3",
          artist: Artist(
            id: 1562681,
            name: "Ariana Grande",
            picture:
                "https://m.media-amazon.com/images/M/MV5BMTg3NzQzMmYtNWQxNS00NDYzLTgzMTctNmRkOTE2ZjlkYWJhXkEyXkFqcGdeQXVyMjAwMzU2MDY@._V1_.jpg",
            pictureBig:
                "https://e-cdns-images.dzcdn.net/images/artist/3b99aa38bc4f58b05d6671c918eeb03e/500x500-000000-80-0-0.jpg",
            tracklist: "https://api.deezer.com/artist/1562681/top?limit=50",
          ),
          album: Album(
            id: 13139438,
            title: "Dangerous Woman",
            cover_medium:
                "https://e-cdns-images.dzcdn.net/images/cover/e5bf0368c12f211bdafe91deba06cdda/250x250-000000-80-0-0.jpg",
            tracklist: "https://api.deezer.com/album/13139438/tracks",
          ),
        ),
        Track(
          id: 7474206,
          title: "Back To December",
          link: "https://www.deezer.com/track/7474206",
          preview: "https://cdns-preview-1.dzcdn.net/stream/c-17e79183d48441625bfc77b3b4ebd0d1-10.mp3",
          artist: Artist(
            id: 12246,
            name: "Taylor Swift",
            picture: "https://billboardvn.vn/wp-content/uploads/2022/12/2022-12-07-12.42.27-PM.jpg",
            pictureBig:
                "https://e-cdns-images.dzcdn.net/images/artist/8a73d18f63b3c395f7d28da96185478d/500x500-000000-80-0-0.jpg",
            tracklist: "https://api.deezer.com/artist/12246/top?limit=50",
          ),
          album: Album(
            id: 689149,
            title: "Speak Now (Deluxe Package)",
            cover_medium:
                "https://e-cdns-images.dzcdn.net/images/cover/3d4f5060d8c90f084d3433b4e439db6c/250x250-000000-80-0-0.jpg",
            tracklist: "https://api.deezer.com/album/689149/tracks",
          ),
        )
      ]
    }
  ];
}
