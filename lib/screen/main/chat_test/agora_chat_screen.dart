

import 'package:flutter/material.dart';
import 'package:task_management_app/widget/custom_widget/custom_appbar.dart';
import 'package:task_management_app/widget/custom_widget/custom_background.dart';

class AgoraChatScreen extends StatefulWidget {
  const AgoraChatScreen({Key? key}) : super(key: key);

  @override
  _AgoraChatScreenState createState() => _AgoraChatScreenState();
}

class _AgoraChatScreenState extends State<AgoraChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              CustomAppBar(
                title: "Agora Chat",
              )
            ],
          ),
        ),
      ),
    );
  }
}
