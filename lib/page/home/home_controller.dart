import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:musicapp/service/network_data/api_service/api_service.dart';

import '../../models/track_model.dart';
import '../../service/network_data/api_requests/base_request/request_model.dart';

class RequestSearch extends RequestModel {
  RequestSearch(String params) : super('search', RequestMethod.getMethod, params);
}

class HomeController extends GetxController {
  RxList<Track> listTrack = <Track>[].obs;
  RxBool isLoadingTrack = false.obs;
  RxBool isPainting = false.obs;
  final TextEditingController searchController = TextEditingController();

  void searchTrackByKeyword(String keyword) async {
    if (keyword.trim() == '') {
      Fluttertoast.showToast(msg: 'Please enter keyword seach!');
      return;
    }
    isLoadingTrack.value = true;
    var request = RequestSearch(keyword);
    request.route = "${request.route}?q=$keyword";
    var response = await ApiServices().request(request);
    listTrack.value = List<Track>.from(response['data'].map((x) => Track.fromMap(x)));
    // searchController.clear();
    // listTrack.value.remove(listTrack.where((p0) => p0.id))
    isLoadingTrack.value = false;
  }
}
