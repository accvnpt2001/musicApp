import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicapp/util/MPColors.dart';
import 'package:musicapp/util/app_routes.dart';

import '../../configs/app_images.dart';
import '../../util/j_text.dart';
import 'favorite_controller.dart';

class FavoritePage extends GetView<FavoriteController> {
  @override
  Widget build(BuildContext context) {
    controller.getListFavorite();
    return Scaffold(
        backgroundColor: mpSearchBarBackGroundColor,
        appBar: AppBar(
          leading: SizedBox(),
          centerTitle: true,
          title: const JText(
            fontSize: 20,
            text: "Favorite Songs",
            textColor: Colors.white,
          ),
          backgroundColor: mpAppBackGroundColor,
          shadowColor: Colors.transparent,
        ),
        body: Obx(
          () => controller.list.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: () => controller.refreshList(),
                  child: !controller.reLoad.value
                      ? ListView.builder(
                          itemBuilder: (context, index) => buildItemTrack(controller, index),
                          itemCount: controller.list.length,
                        ).paddingSymmetric(horizontal: 6.w).paddingOnly(bottom: 50.h)
                      : const Center(
                          child: CircularProgressIndicator(
                            color: mpAppButtonColor,
                          ),
                        ),
                )
              : Center(
                  child: JText(
                    text: 'Data not found',
                    textColor: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
        ));
  }
}

Widget buildItemTrack(FavoriteController controller, int index) {
  return InkWell(
    onTap: () => Get.toNamed(RouterNames.TRACK_PAGE, arguments: {
      'indexTrack': index,
      'list': controller.list,
    }),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60.w,
              width: 60.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                    ),
                  ),
                  imageUrl: controller.list[index].artist.picture,
                  placeholder: (context, _) => Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.DEFAULT_IMG_TRACK),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.DEFAULT_IMG_TRACK),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  JText(
                    pin: EdgeInsets.only(top: 10.h, bottom: 5.h),
                    text: controller.list[index].title,
                    fontSize: 14,
                    width: Get.width,
                    lineSpacing: 1.2,
                    textAlign: TextAlign.start,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w600,
                    // textOverflow: TextOverflow.ellipsis,
                  ),
                  JText(
                    textAlign: TextAlign.center,
                    textOverflow: TextOverflow.clip,
                    text: controller.list[index].artist.name,
                    textColor: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w100,
                  ),
                ],
              ).paddingOnly(left: 10.w),
            ),
            const Icon(Icons.play_circle_outline, color: mpAppButtonColor, size: 30).paddingSymmetric(horizontal: 5.w),
          ],
        ).paddingSymmetric(vertical: 5.h),
        const Divider(
          height: 5,
          color: mpAppButtonColor,
          indent: 30,
          endIndent: 30,
        ),
      ],
    ),
  );
}
