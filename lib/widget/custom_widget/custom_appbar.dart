

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_management_app/style/color.dart';

import 'custom_icon.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget {
  final GestureTapCallback? onTapLead;
  final GestureTapCallback? onTapLead1;
  final IconData? iconLead;
  final IconData? iconLead1;
  final Color? iconColor;
  final double? iconSize;
  final String? title;
  const CustomAppBar({Key? key,  this.onTapLead, this.onTapLead1, this.iconLead, this.iconLead1, this.iconColor, this.iconSize, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // iconLead == null ? CustomIcon(bgColor: Colors.transparent,) :
          GestureDetector(
            onTap: onTapLead ?? () => Modular.to.pop(context),
            child: CustomIcon(
              icon: iconLead ?? FontAwesomeIcons.arrowLeft,
              iconColor: iconColor ?? AppColor.primaryColor,
              iconSize: iconSize ??  20,
            ),
          ),
          CustomText(
            text: title ?? "",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconLead1 == null ? CustomIcon(bgColor: Colors.transparent,) :
          GestureDetector(
            onTap: onTapLead1,
            child: CustomIcon(
              icon: iconLead1,
              iconColor: iconColor ?? AppColor.primaryColor,
              iconSize: iconSize ?? 20,
            ),
          ),
        ],
      ),
    );
  }
}
