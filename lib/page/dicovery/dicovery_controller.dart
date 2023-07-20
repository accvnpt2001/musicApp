import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musicapp/service/network_data/api_service/api_service_get_list.dart';
import 'package:musicapp/util/app_routes.dart';

import '../../models/track_model.dart';

class DiscoveryController extends GetxController {
  RxList<Track> listRecent = <Track>[].obs;

  void onClickHotRecommend(Track track) async {
    EasyLoading.show();
    var response = await ApiServicesGet().request(track.artist.tracklist);
    var listTrack = List<Track>.from(response['data'].map((x) => Track.fromMap(x)));
    listTrack.forEach((e) {
      e.artist.pictureBig = track.artist.pictureBig;
      e.artist.picture = track.artist.pictureBig;
    });
    listTrack.add(track);
    listTrack = List.from(listTrack.reversed);
    EasyLoading.dismiss();
    Get.toNamed(RouterNames.TRACK_PAGE, arguments: {
      'indexTrack': 0,
      'list': listTrack,
    });
  }

  void getListRecent() {
    var storage = GetStorage();
    var listJson = storage.read('recent') ?? [];
    // print(listJson[0]);
    listRecent.clear();
    listJson.forEach((e) {
      var track = Track.fromJson('$e');
      listRecent.add(track);
    });
    listRecent.value = List.from(listRecent.reversed);
    if (listRecent.isEmpty) listRecent.value = <Track>[].obs;
  }
}
