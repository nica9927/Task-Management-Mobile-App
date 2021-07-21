

import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  final Widget? child;
  final double? sigmaX;
  final double? sigmaY;
  final double? opacity;
  final Color? beginColor;
  final Color? endColor;

  const CustomBackground({Key? key, this.child, this.sigmaX, this.sigmaY, this.opacity, this.beginColor, this.endColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaX ?? 0.2, sigmaY: sigmaY ?? 0.2),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
               // beginColor ?? Color(0xff5FC3E4).withOpacity(0.3),
               //  Colors.white.withOpacity(0.1),
               // endColor ??  Color(0xffE55D87).withOpacity(0.3)
                Color(0x3377A1D3),
                Color(0x3379CBCA),
                Color(0x33E684AE),
              ]
          ),
        ),
        child: Container(
          // color: Colors.grey.withOpacity(opacity ?? 0.01),
          child: child ?? null,
        ),
      ),
    );
  }
}
