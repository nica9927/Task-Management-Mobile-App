


import 'package:task_management_app/constants/default_value.dart';
import 'package:task_management_app/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextInputType? inputType;
  final int? flex;
  final IconData? icon;
  final bool isRequire;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String?>? validator;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;
  final FormFieldSetter<String?>? onSaved;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final ValueChanged<String?>? onFieldSubmitted;
  final bool? readOnly;
  final String? initialValue;
  final Color? color;
  final int? minLines;
  final bool obscureText;
  final int? maxLength;
  final bool maxLengthEnforced;
  final Color? colorReadOnly;
  final Color? iconColor;
  final String? suffixText;
  final double? iconSize;
  final BorderRadius? borderRadius;

  const MyTextFormField({
    Key? key,
    this.label,
    this.hint,
    this.inputType,
    this.flex = 1,
    this.icon,
    this.isRequire = false,
    this.inputFormatters = const [],
    this.onChanged,
    this.validator,
    this.autovalidateMode,
    this.controller,
    this.onSaved,
    this.maxLines,
    this.minLines,
    this.textInputAction,
    this.onFieldSubmitted,
    this.readOnly,
    this.initialValue,
    this.color,
    this.obscureText = false,
    this.maxLength,
    this.maxLengthEnforced = false,
    this.colorReadOnly,
    this.iconColor,
    this.suffixText,
    this.iconSize,
    this.borderRadius

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: TextFormField(
        maxLength: maxLength,
        maxLengthEnforced: maxLengthEnforced,
        initialValue: controller != null ? null : initialValue,
        readOnly: readOnly ?? false,
        obscureText: obscureText,
        textInputAction: textInputAction,
        controller: controller,
        onSaved: onSaved,
        style: GoogleFonts.roboto(color:  colorReadOnly ?? Colors.black87,  fontSize: 14),
        cursorColor: Colors.black54,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        validator: (value) {
          if (isRequire && value!.isEmpty) return DefaultError.isRequireMessage;
          if (validator != null) return validator!(value);
          return null;
        },
        autovalidateMode: autovalidateMode,
        inputFormatters: inputFormatters ?? [],
        keyboardType: inputType ?? TextInputType.text,
        maxLines: maxLines ?? 1,
        minLines: minLines,
        decoration: InputDecoration(
          suffixText: suffixText ?? "",
          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: borderRadius ??  BorderRadius.circular(50)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: borderRadius ?? BorderRadius.circular(50)),
          filled: true,
          counterText: "",
          prefixIcon: icon == null
              ? null
              : Icon(
            icon,
            color: iconColor ?? AppColor.primaryColor.withOpacity(0.8),
            size: iconSize ?? 20,
          ),
          focusColor: AppColor.primaryColor,
          hoverColor: AppColor.primaryColor,
          labelText: label,
          labelStyle: GoogleFonts.roboto(color: Colors.black54.withOpacity(0.8), fontWeight: FontWeight.bold),
          alignLabelWithHint: true,
          hintText: hint,
          hintStyle: GoogleFonts.roboto(
            color: Colors.grey,
            fontSize: 16
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          fillColor: color == null ? AppColor.primaryColor.withOpacity(0.2) : color,
        ),
      ),
    );
  }
}
