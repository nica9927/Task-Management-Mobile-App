import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/screen/main/home/home_provider.dart';
import 'package:task_management_app/style/color.dart';
import 'package:task_management_app/widget/button_shadow_widget.dart';
import 'package:task_management_app/widget/custom_widget/custom_background.dart';
import 'package:task_management_app/widget/custom_widget/custom_container.dart';
import 'package:task_management_app/widget/custom_widget/custom_text.dart';
import 'package:task_management_app/widget/my_text_form_field.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, vm, child) {
        return Scaffold(
          body: CustomBackground(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  SizedBox(height: 100,),
                  CustomContainer(
                    child: Form(
                      key: form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Welcome Back!",
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 8,),
                          CustomText(
                            text: "Sign in to continue",
                            fontSize: 18,
                          ),
                          SizedBox(height: 16,),
                          CustomText(
                            text: "Username",
                          ),
                          MyTextFormField(
                            color: Colors.white,
                            icon: FontAwesomeIcons.userAlt,
                            onSaved: (newValue) => vm.username = newValue!,
                          ),
                          CustomText(
                            text: "Password",
                          ),
                          MyTextFormField(
                            color: Colors.white,
                            icon: FontAwesomeIcons.key,
                            onSaved: (newValue) => vm.password = newValue!,
                          ),
                          GestureDetector(
                            onTap: (){
                              form.currentState!.save();
                              vm.login(context);
                            },
                            child: ButtonShadowWidget(
                              color: AppColor.primaryColor,
                              label: "Login",
                              textColor: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
