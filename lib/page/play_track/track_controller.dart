import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musicapp/util/j_text.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/track_model.dart';

class TrackController extends GetxController {
  RxList<Track> listTrack = <Track>[].obs;
  RxInt indexTrackPlaying = 0.obs;
  RxList<Track> listTrackArtist = <Track>[].obs;
  RxList<int> listIdFavorite = <int>[].obs;
  PageController pageController = PageController(initialPage: 0);

  RxDouble currentVolume = 0.0.obs;

  // final audioPlayer = AudioPlayer();
  final audioAsset = AssetsAudioPlayer();
  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> position = Duration.zero.obs;

  @override
  void onInit() async {
    EasyLoading.show();
    listTrack.value = Get.arguments['list'] as List<Track>;
    getListFavoriteId();

    await audioAsset.open(
        Playlist(
            audios: List.generate(
          listTrack.length,
          (index) => Audio.network(
            listTrack[index].preview,
            metas: Metas(
                id: listTrack[index].id.toString(),
                title: listTrack[index].title,
                artist: listTrack[index].artist.name,
                image: MetasImage.network(listTrack[index].artist.pictureBig),
                album: listTrack[index].album?.title ?? ""),
          ),
        )),
        showNotification: true,
        loopMode: LoopMode.single,
        autoStart: false);
    indexTrackPlaying.value = Get.arguments['indexTrack'] as int;
    audioAsset.playlistPlayAtIndex(indexTrackPlaying.value);
    EasyLoading.dismiss();

    currentVolume.value = await PerfectVolumeControl.volume;
    super.onInit();
  }

  @override
  void onReady() {
    addToRecentList();
    super.onReady();
  }

  @override
  void onClose() {
    audioAsset.dispose();
    EasyLoading.dismiss();
    super.onClose();
  }

  Future nextTrack() async {
    if (indexTrackPlaying.value < listTrack.length - 1) {
      indexTrackPlaying.value++;
      audioAsset.next();
    } else {
      Get.snackbar("Alert", "",
          backgroundColor: Colors.white,
          messageText: const JText(
            text: "No follow up song",
            textColor: Color.fromARGB(255, 76, 175, 173),
          ));
    }
    addToRecentList();
  }

  Future gotoTrack(int index) async {
    indexTrackPlaying.value = index;
    audioAsset.playlistPlayAtIndex(index);
    addToRecentList();
  }

  Future backTrack() async {
    if (indexTrackPlaying.value > 0) {
      indexTrackPlaying.value--;
      audioAsset.previous();
    } else {
      Get.snackbar("Alert", "",
          backgroundColor: Colors.white,
          messageText: const JText(
            text: "No previous track",
            textColor: Color.fromARGB(255, 76, 175, 173),
          ));
    }
    addToRecentList();
  }

  void pauseAndResumeTrack() async {
    audioAsset.isPlaying.value == false ? await audioAsset.play() : await audioAsset.pause();
  }

  void addToFavorite() {
    var storage = GetStorage();
    var item = listTrack[indexTrackPlaying.value].toJson();
    var list = storage.read('favorite') ?? [];
    bool a = false;
    list.forEach((e) {
      var track = Track.fromJson(e);
      if (track.id == listTrack[indexTrackPlaying.value].id) {
        a = true;
        list.remove(e);
        getListFavoriteId();
        return;
      }
    });
    if (!a) {
      list.add(item);
    }
    getListFavoriteId();
    storage.write('favorite', list);
  }

  void addToRecentList() {
    var storage = GetStorage();
    var item = listTrack[indexTrackPlaying.value].toJson();
    var list = storage.read('recent') ?? [];
    bool a = false;
    list.forEach((e) {
      var track = Track.fromJson(e);
      if (track.id == listTrack[indexTrackPlaying.value].id) {
        a = true;
        list.remove(e);
        return;
      }
    });
    if (!a) {
      list.add(item);
    }
    print("list $list");
    storage.write('recent', list);
  }

  void getListFavoriteId() {
    var storage = GetStorage();
    var list = storage.read('favorite') ?? [];
    listIdFavorite.clear();
    list.forEach((e) {
      var track = Track.fromJson(e);
      listIdFavorite.add(track.id);
    });
    print('okela ${listIdFavorite}');
  }

  void on2FingerVeticalUp() {
    //open Web View
    launchUrl(Uri.parse(listTrack[indexTrackPlaying.value].link), mode: LaunchMode.externalApplication);
  }

  void on2FingerVeticalDown() async {
    // share Music
    await Share.share(listTrack[indexTrackPlaying.value].link);
  }

  void on2FingerHorizontalRight() {
    audioAsset.setLoopMode(LoopMode.single);
  }

  void on2FingerHorizontalLeft() {
    audioAsset.setLoopMode(LoopMode.playlist);
  }

  void on4FingerHover() {
    audioAsset.setPlaySpeed(1.5);
  }

  void on3FingerHover() {
    // audioAsset.setPlaySpeed(1);
    audioAsset.setPitch(1.3);
  }
}
