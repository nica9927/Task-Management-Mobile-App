


import 'package:task_management_app/constants/default_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormText extends StatelessWidget {
  final String? title;
  final bool readOnly;
  final VoidCallback? onTab;
  final TextEditingController? controller;
  final IconData? icon;
  final bool isRequire;
  final FormFieldSetter<String>? onSaved;
  final TextInputType? inputType;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final String? initValue;
  final String? suffixText;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  const FormText({
    Key? key,
    this.title,
    this.readOnly = false,
    this.onTab,
    this.controller,
    this.icon,
    this.isRequire = false,
    this.onSaved,
    this.inputType,
    this.maxLines,
    this.minLines,
    this.inputFormatters,
    this.initValue,
    this.onChanged,
    this.suffixText,
    this.textInputAction,
    this.onFieldSubmitted,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                title!,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              if (isRequire)
                Text(
                  "*",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                )
            ],
          ),
          TextFormField(
            controller: initValue == null ? controller : null,
            initialValue: initValue,
            onFieldSubmitted: onFieldSubmitted,
            readOnly: readOnly,
            onTap: onTab,
            textInputAction: textInputAction,
            onChanged: (value) => onChanged != null ? onChanged!(value) : null,
            onSaved: onSaved,
            keyboardType: inputType,
            maxLines: maxLines,
            minLines: minLines,
            inputFormatters: inputFormatters ?? [],
            validator: (value) {
              if (isRequire && value!.isEmpty) return DefaultError.isRequireMessage;
              if (validator != null) return validator!(value);
              return null;
            },
            decoration: InputDecoration(
              suffixText: suffixText,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red[200]!,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red[300]!,
                ),
              ),
              suffixIcon: icon != null ? Icon(icon) : null,
            ),
          ),
        ],
      ),
    );
  }
}