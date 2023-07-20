import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musicapp/models/track_model.dart';

class FavoriteController extends GetxController {
  RxList<Track> list = <Track>[].obs;
  Rx<bool> reLoad = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void removeTrackFavorite(int index) {
    getListFavorite();
    var storage = GetStorage();
    var list2 = storage.read('favorite') ?? [];
    list2.forEach((e) {
      var track = Track.fromJson(e);
      if (track.id == list[index].id) {
        if (list2.length == 1)
          list2 = [];
        else {
          list2.remove(e);
        }
      }
    });
    storage.write('favorite', list2);
    getListFavorite();
  }

  void getListFavorite() {
    var storage = GetStorage();
    var listJson = storage.read('favorite') ?? [];
    // print(listJson[0]);
    list.clear();
    listJson.forEach((e) {
      var track = Track.fromJson('$e');
      list.add(track);
    });
    if (list.isEmpty) list.value = <Track>[].obs;
  }

  Future<void> refreshList() async {
    reLoad.value = true;
    Future.delayed(Duration(seconds: 2)).then((value) {
      reLoad.value = false;
    });
  }
}
