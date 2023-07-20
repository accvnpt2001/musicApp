import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicapp/page/play_track/track_controller.dart';
import 'package:musicapp/util/image_track.dart';
import 'package:musicapp/util/j_text.dart';
import '../models/track_model.dart';

class BottomSheetCustom {
  static void showBottomSheet(List<Track> list) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.45,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.5),
              Colors.grey.withOpacity(0.5),
            ],
            stops: [0.0, 1.0],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.find<TrackController>().gotoTrack(index);
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.all(5.h),
                margin: EdgeInsets.all(5.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    ImageTrack(
                        height: 50.h,
                        width: 50.h,
                        imageUrl: list[index].artist.picture),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          JText(
                            text: list[index].title,
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          JText(
                            pin: EdgeInsets.symmetric(vertical: 5.h),
                            text: list[index].artist.name,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: list.length,
        ),
      ),
    );
  }
}
