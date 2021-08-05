import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  final int? maxLine;
  final TextAlign? textAlign;
  const CustomText({Key? key, this.text, this.fontSize, this.fontWeight, this.color, this.overflow, this.maxLine, this.padding, this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: AutoSizeText(
        text ?? "",
        style: GoogleFonts.prompt(
            fontSize: fontSize,
            fontWeight: fontWeight ?? null,
            color: color ?? Colors.black87.withOpacity(0.8)
        ),
        overflow: overflow,
        maxLines: maxLine,
        textAlign: textAlign ?? null,
      ),
    );
  }
}
