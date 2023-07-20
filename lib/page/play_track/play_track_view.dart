// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:isolate';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:musicapp/page/play_track/track_controller.dart';
import 'package:musicapp/service/download_mp3.dart/download_helper.dart';
import 'package:musicapp/util/bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

import '../../configs/app_images.dart';
import '../../util/MPColors.dart';
import '../../util/j_text.dart';

class PlayTrackPage extends StatefulWidget {
  PlayTrackPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayTrackPage> createState() => _PlayTrackPageState();
}

class _PlayTrackPageState extends State<PlayTrackPage> {
  TrackController controller = Get.put(TrackController());
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mpSearchBarBackGroundColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const JText(
          fontSize: 20,
          text: "Music PodCast",
          textColor: Colors.white,
        ).onTap(() => controller.on3FingerHover()),
        backgroundColor: Color(0xff7E3CF2),
        shadowColor: Colors.transparent,
      ),
      body: GestureDetector(
        onVerticalDragStart: (details) {
          BottomSheetCustom.showBottomSheet(controller.listTrack);
        },
        onHorizontalDragEnd: (details) {
          Get.back();
        },
        child: Stack(
          children: [
            Container(
              height: Get.height,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.BACKGROUND_TRACK), fit: BoxFit.cover),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.6,
                  child: Expanded(
                    child: PageView(
                      controller: controller.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        imageTrackArtist(controller, context),
                      ],
                    ),
                  ),
                ),
                progressAudio(controller),
                buttonControl(controller),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget imageTrackArtist(TrackController controller, BuildContext context) {
  final events = [];
  final eventCount = [];
  // double scaleFactor = 1.0;
  return StreamBuilder<Duration>(
      stream: controller.audioAsset.currentPosition,
      builder: (context, snapshot) {
        if (snapshot.data != null && snapshot.data! < const Duration(seconds: 1)) {
          if (controller.audioAsset.readingPlaylist?.currentIndex != null) {
            controller.indexTrackPlaying.value = controller.audioAsset.readingPlaylist!.currentIndex;
          }
        }
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: Get.width,
              width: Get.width,
              child: Listener(
                onPointerDown: (event) {
                  events.add(event.pointer);
                },
                onPointerUp: (event) {
                  events.clear();
                  eventCount.clear();
                },
                // onPointerCancel: ,
                onPointerMove: (event) async {
                  if (events.length == 2 && eventCount.isEmpty) {
                    int sensitivity = 4;
                    // drag vertical Down 2 finger
                    if (event.delta.dy > sensitivity) {
                      Get.snackbar("Phát hiện cử chỉ", "2 finger Down", backgroundColor: Colors.white);
                      eventCount.add(2);
                      controller.on2FingerVeticalDown();
                    } // drag vertical Up 2 finger
                    else if (event.delta.dy < -sensitivity) {
                      Get.snackbar("Phát hiện cử chỉ", "2 finger Up", backgroundColor: Colors.white);
                      controller.on2FingerVeticalUp();
                      eventCount.add(2);
                    } else if (event.delta.dx > 3) {
                      Get.snackbar("Phát hiện cử chỉ", "2 finger Right", backgroundColor: Colors.white);
                      eventCount.add(2);
                      controller.on2FingerHorizontalRight();
                    } else if (event.delta.dx < -3) {
                      Get.snackbar("Phát hiện cử chỉ", "2 finger Left", backgroundColor: Colors.white);
                      eventCount.add(2);
                      controller.on2FingerHorizontalLeft();
                    }
                  } else if (events.length == 4 && eventCount.isEmpty) {
                    Get.snackbar("Phát hiện cử chỉ", "4 finger hover", backgroundColor: Colors.white);
                    eventCount.add(4);
                  } else if (events.length == 3 && eventCount.isEmpty) {
                    Get.snackbar("Phát hiện cử chỉ", "3 finger hover", backgroundColor: Colors.white);
                    eventCount.add(3);
                    controller.on3FingerHover();
                  }
                },
                child: GestureDetector(
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    if (events.length < 2 && eventCount.isEmpty) {
                      // Xử lý hành động vuốt theo chiều dọc
                      double delta = details.delta.dy;
                      // Tính toán tăng giảm âm lượng dựa trên giá trị delta
                      double volumeChange = delta > 0 ? -0.005 : 0.005;
                      double newVolume = controller.currentVolume.value + volumeChange;
                      newVolume = newVolume.clamp(0.0, 1.0); // Giới hạn âm lượng trong khoảng từ 0.0 đến 1.0

                      controller.currentVolume.value = newVolume;

                      PerfectVolumeControl.setVolume(newVolume);
                    } // Cập nhật âm lượng cho audio player
                  },
                  onHorizontalDragEnd: (details) {
                    if (events.length < 2 && eventCount.isEmpty) {
                      if (details.velocity.pixelsPerSecond.dx < 0) {
                        controller.nextTrack();
                      } else if (details.velocity.pixelsPerSecond.dx > 0) {
                        controller.backTrack();
                      }
                    }
                  },
                  onLongPressEnd: (a) {
                    if (events.length < 2 && eventCount.isEmpty) {
                      a.velocity.pixelsPerSecond.distanceSquared < 0;
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            // <-- SEE HERE
                            title: const Text('Alert'),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Text('Are you sure want to download?'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('No'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () {
                                  DownloadHelper.downloadFile(
                                    controller.listTrack[controller.indexTrackPlaying.value].preview,
                                  );
                                  Get.back();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  onDoubleTap: () {
                    controller.addToFavorite();
                  },
                  child: Obx(() => ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: CachedNetworkImage(
                            imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                                  ),
                                ),
                            imageUrl: controller.listTrack[controller.indexTrackPlaying.value].artist.pictureBig,
                            placeholder: (context, _) => Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(AppImages.DEFAULT_IMG_TRACK), fit: BoxFit.fitWidth),
                                  ),
                                ),
                            errorWidget: (context, url, error) => Center(
                                    child: JText(
                                  text: "No Image Available!",
                                  fontSize: 10.sp,
                                ))),
                      )),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    BottomSheetCustom.showBottomSheet(controller.listTrack);
                  },
                  icon: const Icon(
                    Icons.playlist_play_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 30,
                ),
                Obx(
                  () => Expanded(
                    child: Column(
                      children: [
                        JText(
                          text: controller.listTrack[controller.indexTrackPlaying.value].title,
                          textColor: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        JText(
                          pin: EdgeInsets.symmetric(vertical: 5.h),
                          text: controller.listTrack[controller.indexTrackPlaying.value].artist.name,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.addToFavorite();
                  },
                  icon: Icon(
                    controller.listIdFavorite.contains(controller.listTrack[controller.indexTrackPlaying.value].id)
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    color: mpAppButtonColor,
                  ),
                  iconSize: 30,
                ),
              ],
            )
          ],
        );
      });
}

Widget progressAudio(TrackController controller) {
  return controller.audioAsset.builderRealtimePlayingInfos(builder: (context, realtimePlayingInfos) {
    return Column(
      children: [
        Slider(
          min: 0,
          max: realtimePlayingInfos.duration.inSeconds.toDouble() + 3,
          thumbColor: mpAppButtonColor,
          activeColor: mpAppButtonColor,
          inactiveColor: Colors.grey,
          value: realtimePlayingInfos.currentPosition.inSeconds.toDouble(),
          onChanged: (value) async {
            if (value <= 0) {
              controller.audioAsset.seek(const Duration(seconds: 0));
            } else if (value >= realtimePlayingInfos.duration.inSeconds.toDouble()) {
              controller.audioAsset.seek(realtimePlayingInfos.duration);
            } else {
              controller.audioAsset.seek(Duration(seconds: value.toInt()));
            }
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              JText(
                text: formatTime(realtimePlayingInfos.currentPosition),
                textColor: Colors.white,
              ),
              JText(
                text: formatTime(realtimePlayingInfos.duration - realtimePlayingInfos.currentPosition),
                textColor: Colors.white,
              ),
            ],
          ),
        )
      ],
    );
  });
}

Widget buttonControl(TrackController controller) {
  return controller.audioAsset.builderIsPlaying(builder: (context, isPlaying) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () => controller.backTrack(),
          iconSize: 50,
          color: Colors.white,
          icon: const Icon(CupertinoIcons.backward_end_fill),
        ),
        Container(
          decoration: BoxDecoration(color: mpAppButtonColor.withOpacity(0.7), shape: BoxShape.circle),
          child: IconButton(
            onPressed: () => controller.pauseAndResumeTrack(),
            iconSize: 50,
            color: Colors.white,
            icon: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
          ),
        ),
        IconButton(
          onPressed: () => controller.nextTrack(),
          iconSize: 50,
          color: Colors.white,
          icon: const Icon(CupertinoIcons.forward_end_fill),
        ),
      ],
    );
  });
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(':');
}
