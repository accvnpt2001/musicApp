import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicapp/configs/app_images.dart';
import 'package:musicapp/page/dicovery/dicovery_controller.dart';
import 'package:musicapp/page/dicovery/discovery_constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../util/MPColors.dart';
import '../../util/MPWidget.dart';
import '../../util/app_routes.dart';
import '../../util/j_text.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DiscoveryController());
    controller.getListRecent();
    return Scaffold(
      backgroundColor: mpSearchBarBackGroundColor,
      appBar: AppBar(
        leading: SizedBox(),
        centerTitle: true,
        title: const JText(
          fontSize: 20,
          text: "Discovery",
          textColor: Colors.white,
        ),
        backgroundColor: mpAppBackGroundColor,
        shadowColor: Colors.transparent,
      ),
      body: Column(
        children: [
          _buildHotRecommend(controller),
          const Divider(color: Colors.grey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent playlist', style: boldTextStyle(color: Colors.white)),
              Text('View All', style: primaryTextStyle(color: mpAppButtonColor)).paddingOnly(right: 8),
            ],
          ).paddingOnly(left: 16, right: 16),
          Obx(() => Expanded(
              child: controller.listRecent.isNotEmpty
                  ? GridView.builder(
                      itemCount: controller.listRecent.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1 / 1.1,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Get.toNamed(RouterNames.TRACK_PAGE, arguments: {
                            'indexTrack': index,
                            'list': controller.listRecent,
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 120.w,
                              width: 120.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: CachedNetworkImage(
                                    imageBuilder: (context, imageProvider) => Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                          ),
                                        ),
                                    imageUrl: controller.listRecent[index].artist.picture,
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
                              ),
                            ).paddingSymmetric(vertical: 10.h),
                            JText(
                              text: controller.listRecent[index].title,
                              textColor: Colors.white,
                              textAlign: TextAlign.center,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox())),
        ],
      ).paddingBottom(40.h),
    );
  }
}

Widget _buildHotRecommend(DiscoveryController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      16.height,
      Text('Hot Recommended', style: boldTextStyle(color: Colors.white)).paddingOnly(left: 16),
      8.height,
      SizedBox(
        height: 190,
        child: ListView.builder(
          itemCount: DiscoveryConstants.listTrackRecommend.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 8, right: 8),
          itemBuilder: (context, index) {
            var item = DiscoveryConstants.listTrackRecommend[index];
            return InkWell(
              onTap: () => controller.onClickHotRecommend(item),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonCacheImageWidget(item.artist.picture, 130, width: 250, fit: BoxFit.cover)
                      .cornerRadiusWithClipRRect(10),
                  4.height,
                  Text(item.title, style: primaryTextStyle(color: Colors.white)),
                  4.height,
                  Text(item.album!.title, style: secondaryTextStyle(color: Colors.grey)),
                ],
              ).paddingOnly(left: 8, right: 8),
            );
          },
        ),
      )
    ],
  );
}
