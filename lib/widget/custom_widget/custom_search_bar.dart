

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../my_text_form_field.dart';

class CustomSearchBar extends StatelessWidget {
  final ValueChanged<String?>? onChanged;
  final String? hint;
  const CustomSearchBar({Key? key, this.onChanged, this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: MyTextFormField(
        color: Colors.white.withOpacity(0.3),
        icon: FontAwesomeIcons.search,
        iconColor: Colors.grey.withOpacity(0.5),
        hint: hint ?? "Search",
        onChanged: onChanged,
      ),
    );
  }
}
