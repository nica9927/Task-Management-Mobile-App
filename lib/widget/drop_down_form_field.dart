
import 'package:flutter/material.dart';
import 'package:task_management_app/constants/default_value.dart';
import 'package:task_management_app/style/color.dart';

class FormDropdown<T> extends StatelessWidget {
  final String? title;
  final List<T>? items;
  final String? Function(T item)? onMapping;
  final bool isRequire;
  final ValueChanged<T?>? onSaved;
  final T? initValue;
  final IconData? icon;
  final ValueChanged<T?>? onChange;
  final GlobalKey<FormFieldState<T?>>? formKey;
  final Widget Function(T item)? leading;
  final List<Widget>? children;
  final Color? color;

  const FormDropdown({
    Key? key,
    this.formKey,
    this.title,
    this.items,
    this.onMapping,
    this.leading,
    this.isRequire = false,
    this.onSaved,
    this.initValue,
    this.icon,
    this.onChange,
    this.children = const [],
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          title == "" ? SizedBox(height: 0,) :
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
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.grey[100],
                color: color ?? Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FormField<T>(
                key: formKey,
                initialValue: formKey == null ? initValue : null,
                validator: (value) {
                  if (isRequire && value == null) return DefaultError.isRequireMessage;
                  return null;
                },
                onSaved: (newValue) => onSaved!(newValue),
                builder: (FormFieldState<T> field) {
                  return Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          validator: (dynamic _) => field.errorText,
                          onChanged: (dynamic value) {
                            field.didChange(value);
                            if (onChange != null) onChange!(value);
                          },
                          items: items!.map<DropdownMenuItem<T>>((e) {
                            return DropdownMenuItem<T>(
                              value: e,
                              child: Row(
                                children: [
                                  if (leading != null) ...[
                                    leading!(e),
                                    SizedBox(width: 8),
                                  ],
                                  Text(
                                    onMapping!(e)!,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          value: field.value,
                          decoration: InputDecoration(
                            filled: false,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            // focusedBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: Colors.grey,
                            //   ),
                            // ),
                            // enabledBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: Colors.grey,
                            //   ),
                            // ),
                            // focusedErrorBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //       color: Colors.grey
                            //   ),
                            // ),
                            // errorBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //       color: Colors.grey
                            //   ),
                            // ),
                            // suffixIcon: icon != null ? Icon(icon) : null,
                            prefixIcon: icon != null ? Icon(icon,color: AppColor.primaryColor,) : null,
                          ),
                          iconSize: 0.0,
                        ),
                      ),
                      ...(children ?? []),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
