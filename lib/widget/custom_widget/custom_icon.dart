

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomIcon extends StatelessWidget {
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? bgColor;
  const CustomIcon({Key? key, this.icon, this.iconSize, this.iconColor, this.onTap, this.padding, this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: bgColor ?? Colors.white.withOpacity(0.5),
            shape: BoxShape.circle
        ),
        child: Icon(icon,size: iconSize,color: iconColor),
      ),
    );
  }
}
