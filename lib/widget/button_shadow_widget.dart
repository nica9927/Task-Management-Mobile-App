
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management_app/style/color.dart';


class ButtonShadowWidget extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final Color? iconColor;
  final Color? color;
  final Color? textColor;
  final String? svg;

  const ButtonShadowWidget({
    Key? key,
    this.label,
    this.icon,
    this.iconColor,
    this.color,
    this.textColor,
    this.svg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var c = color ?? Colors.white;
    var t = textColor ?? Colors.black54;
    var l = label == null;
    Widget? _icon = icon == null
        ? null
        : Icon(
            icon,
            size: l ? 20 : 16,
            color: iconColor,
          );
    final Widget? _svg = svg == null
        ? null
        : SvgPicture.asset(
            svg!,
            width: 30,
            height: 30,
          );
    if (_icon == null && _svg != null) {
      _icon = _svg;
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: l ? EdgeInsets.all(8) : EdgeInsets.symmetric(vertical: 12, horizontal: 32),
      decoration: BoxDecoration(
        color: c,
        borderRadius: l ? null : BorderRadius.circular(20),
        shape: l ? BoxShape.circle : BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: (color == null ? Colors.black : c).withOpacity(0.15),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: l
          ? _icon
          : Row(
              children: [
                if (icon != null) _icon!,
                if (label != null)
                  Expanded(
                    child: Text(
                      label!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(fontSize: 18, color: t),
                    ),
                  ),
              ],
            ),
    );
  }
}
