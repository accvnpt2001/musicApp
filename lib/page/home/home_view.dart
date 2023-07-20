import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:musicapp/configs/app_images.dart';
import 'package:musicapp/page/home/home_controller.dart';
import 'package:musicapp/page/home/suggest.dart';
import 'package:musicapp/util/j_text.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../util/MPColors.dart';
import '../../util/app_routes.dart';
import 'digitalDetect.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? currentBackPressTime;
  late stt.SpeechToText _speech;
  bool _isListening = false;

  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    _speech = stt.SpeechToText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: mpSearchBarBackGroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: mpAppBackGroundColor,
          leading: SizedBox(),
          leadingWidth: 0,
          title: buildSearch(controller),
          centerTitle: false,
          actions: [
            InkWell(
              onTap: _listen,
              child: SizedBox(
                width: 30,
                child: AvatarGlow(
                  animate: _isListening,
                  child: Icon(Icons.settings_voice_outlined),
                  glowColor: Colors.white,
                  endRadius: 75,
                  duration: Duration(seconds: 2),
                  repeatPauseDuration: Duration(milliseconds: 100),
                  repeat: true,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                controller.isPainting.value = !controller.isPainting.value;
              },
              icon: const Icon(Icons.edit_rounded),
            ).paddingOnly(right: 16),
          ],
        ),
        body: Stack(
          children: [
            GestureDetector(
              child: bodyHome(controller),
              onTap: () {
                FocusScope.of(context).unfocus();
                controller.isPainting.value = false;
              },
            ),
            Obx(() => controller.isPainting.value
                ? ChangeNotifierProvider(
                    create: (contex) => DigitalInkRecognitionState(),
                    child: DigitalInkRecognitionPage(),
                  )
                : SizedBox())
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Tap again to exit",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      SystemNavigator.pop();
    }
    return Future.value(false);
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            controller.searchController.text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}

Widget bodyHome(HomeController controller) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.w),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        buildListTrack(controller),
      ],
    ),
  );
}

Widget buildListTrack(HomeController controller) {
  return Obx(
    () => !controller.isLoadingTrack.value
        ? Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(bottom: 10.h),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1.1,
                crossAxisCount: 2,
                mainAxisSpacing: 40,
              ),
              itemBuilder: (context, index) => buildItemTrack(controller, index),
              itemCount: controller.listTrack.length,
            ),
          )
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
  );
}

Widget buildItemTrack(HomeController controller, int index) {
  return GestureDetector(
    onTap: () => Get.toNamed(RouterNames.TRACK_PAGE, arguments: {
      'indexTrack': index,
      'list': controller.listTrack,
    }),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 120.w,
          width: 120.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                      ),
                    ),
                imageUrl: controller.listTrack[index].artist.picture,
                placeholder: (context, _) => Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage(AppImages.DEFAULT_IMG_TRACK), fit: BoxFit.fitWidth),
                      ),
                    ),
                errorWidget: (context, url, error) => Center(
                        child: JText(
                      text: "No Image Available!",
                      fontSize: 10.sp,
                    ))),
          ),
        ),
        Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.center,
              child: Image.asset(
                AppImages.DVD,
                width: 80.w,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: JText(
                pin: EdgeInsets.only(top: 10.h, bottom: 5.h),
                text: controller.listTrack[index].title,
                fontSize: 12,
                textAlign: TextAlign.center,
                textColor: Colors.white,
                fontWeight: FontWeight.w600,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Expanded(
          child: JText(
            textAlign: TextAlign.center,
            textOverflow: TextOverflow.clip,
            text: controller.listTrack[index].artist.name,
            textColor: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    ),
  );
}

Widget buildSearch(HomeController controller) {
  return Padding(
    padding: const EdgeInsets.only(right: 0, top: 8),
    child: SizedBox(
        height: 40,
        width: double.infinity,
        child: TypeAheadField(
          noItemsFoundBuilder: (context) => const SizedBox(),
          suggestionsBoxDecoration: const SuggestionsBoxDecoration(
              color: Colors.white,
              elevation: 4.0,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          debounceDuration: const Duration(milliseconds: 400),
          textFieldConfiguration: TextFieldConfiguration(
              controller: controller.searchController,
              onChanged: (value) {
                if (value.trim() != '') controller.searchTrackByKeyword(value);
              },
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                    15.0,
                  )),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Search on Music PodCast...",
                  contentPadding: const EdgeInsets.only(top: 4, left: 10),
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.searchTrackByKeyword(controller.searchController.text);
                      },
                      icon: const Icon(Icons.search, color: Colors.grey)),
                  fillColor: Colors.white,
                  filled: true)),
          suggestionsCallback: (value) {
            return StateService.getSuggestions(value);
          },
          itemBuilder: (context, String suggestion) {
            return Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      suggestion,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            );
          },
          onSuggestionSelected: (String suggestion) {
            controller.searchTrackByKeyword(suggestion);
            controller.searchController.text = suggestion;
          },
        )),
  );
}
