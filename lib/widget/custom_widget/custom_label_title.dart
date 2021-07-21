

import 'package:flutter/material.dart';
import 'package:task_management_app/style/color.dart';
import 'package:task_management_app/widget/custom_widget/custom_icon.dart';

import 'custom_text.dart';

class CustomLabelTitle extends StatelessWidget {
  final String? title;
  final String? label;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;
  final GestureTapCallback? onTap;
  const CustomLabelTitle({Key? key, this.title, this.label, this.icon, this.padding, this.iconSize, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? null,
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 30,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomText(
                text: title ?? "",
                fontSize: 17.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon != null ?
            CustomIcon(
              icon: icon,
              iconColor: AppColor.primaryColor,
              iconSize: iconSize ??  18,
            )
                :
            CustomText(
              text: label ?? "",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
