

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:octo_image/octo_image.dart';
import 'package:task_management_app/style/color.dart';

class CustomProfileImage extends StatelessWidget {
  final String photoPath;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Decoration? decoration;
  final BorderRadius? borderRadius;
  final bool? isCircle;
  const CustomProfileImage({Key? key,required this.photoPath, this.fit, this.height, this.width, this.decoration, this.borderRadius, this.isCircle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(50),
        child: OctoImage(
          placeholderBuilder: (_) => Center(
              child: SpinKitThreeBounce(
                color: AppColor.primaryColor,
                size: 10,
              )),
          errorBuilder: (context, error, stacktrace) {
            return OctoImage(
              imageBuilder: OctoImageTransformer.circleAvatar(),
              fit: BoxFit.cover,
              image : NetworkImage(
                "https://image.freepik.com/free-vector/coming-soon-shop-announcement-vector_53876-57828.jpg",
              ),
            );
          },
          fit: fit ?? BoxFit.cover,
          imageBuilder: isCircle == true ? OctoImageTransformer.circleAvatar() : null ,
          width: width ?? 60,
          height: height ?? 60,
          image: NetworkImage(photoPath),
        ),
      ),
      decoration: decoration ?? BoxDecoration(color: Colors.white, shape: BoxShape.circle),
    );
  }
}
