import 'package:task_management_app/style/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SelectDateTimeFormField extends StatelessWidget {
  final bool dateOnly;
  final String? label;
  final String? hint;
  final DateFormat? dateFormat;
  final GlobalKey<FormFieldState<DateTime>>? controller;
  final FormFieldSetter<DateTime>? onSaved;
  final bool isRequired;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onChange;
  final bool readOnly;
  final Color? color;
  final IconData? icon;
  final Color? colorReadOnly;

  const SelectDateTimeFormField({
    Key? key,
    this.dateOnly = true,
    this.label,
    this.hint,
    this.dateFormat,
    this.controller,
    this.onSaved,
    this.isRequired = false,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChange,
    this.readOnly = false,
    this.color,
    this.icon,
    this.colorReadOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var df = dateFormat ?? DateFormat('EEEE, dd MMMM yyyy');
    return FormField<DateTime>(
      key: controller,
      onSaved: onSaved,
      initialValue: initialDate,
      validator: (value) {
        if (value == null && isRequired) return "This field is required";
        return null;
      },
      builder: (field) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onTap: readOnly
                    ? null
                    : () async {
                  var date = await showDatePicker(
                    context: context,
                    initialDate: initialDate ?? firstDate ?? DateTime.now().subtract(Duration(days: 356 * 21)),
                    firstDate: firstDate ?? DateTime.now().subtract(Duration(days: 356 * 300)),
                    lastDate: lastDate ?? DateTime.now(),
                  );
                  if (date != null) {
                    field.didChange(date);
                    if(onChange != null) onChange!(date);
                  }
                },
                style: TextStyle(color:  colorReadOnly ?? Colors.black87,  fontSize: 14),
                controller: TextEditingController(text: field.value == null ? "" : df.format(field.value!)),
                // style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
                cursorColor: Colors.deepOrange,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(50)),
                  filled: true,
                  prefixIcon: icon == null
                      ? null
                      : Icon(
                    icon,
                    color: AppColor.primaryColor.withOpacity(0.8),
                  ),
                  focusColor: Colors.red,
                  hoverColor: Colors.red,
                  labelText: label,
                  hintText: hint,
                  labelStyle: TextStyle(color:  colorReadOnly ?? Colors.black87,  fontSize: 14),
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  fillColor: color == null ? AppColor.primaryColor.withOpacity(0.2) : color,
                ),
              ),
              if (field.hasError)
                Text(
                  field.errorText!,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
            ],
          ),
        );
      },
    );
  }
}
