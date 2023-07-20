// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musicapp/util/j_text.dart';

import '../configs/app_images.dart';

class ImageTrack extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  const ImageTrack({
    Key? key,
    required this.height,
    required this.width,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: CachedNetworkImage(
            imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                  ),
                ),
            imageUrl: imageUrl,
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
    );
  }
}
