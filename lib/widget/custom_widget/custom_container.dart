

import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? bgColor;
  final BorderRadiusGeometry? borderRadius;
  final double? height;
  final double? width;
  final double? opacity;
  final Gradient? gradient;
  const CustomContainer({Key? key, this.child, this.padding, this.margin, this.bgColor, this.borderRadius, this.height, this.width, this.opacity, this.gradient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(15),
      height: height ?? null,
      width: width ?? null,
      decoration: BoxDecoration(
          color: bgColor ?? Colors.white.withOpacity(opacity ?? 0.3),
          borderRadius: borderRadius ?? BorderRadius.circular(15),
          gradient: gradient ?? null
      ),
      margin: margin ?? EdgeInsets.symmetric(horizontal: 24,vertical: 10),
      child: child,
    );
  }
}
