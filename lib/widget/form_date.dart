

import 'package:task_management_app/constants/props.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'form_text.dart';

class FormDate extends StatelessWidget {
  final String? title;
  final DateFormat? dateFormat;
  final ValueChanged<DateTime?>? onSaved;
  final DateTime? initValue;

  const FormDate({Key? key, this.title, this.dateFormat, this.onSaved, this.initValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      initialValue: initValue,
      onSaved: (newValue) => onSaved!(newValue),
      builder: (FormFieldState<DateTime> field) {
        return FormText(
          controller: TextEditingController(text: field.value == null ? "" : "${(dateFormat ?? formatterData).format(field.value!)}"),
          title: title,
          readOnly: true,
          icon: Icons.cake_rounded,
          onTab: () async {
            var now = DateTime.now();
            var date = await showDatePicker(
              context: context,
              initialDate: field.value ?? now,
              firstDate: now.subtract(Duration(days: 365 * 300)),
              lastDate: now,
            );
            if (date != null) field.didChange(date);
          },
        );
      },
    );
  }
}