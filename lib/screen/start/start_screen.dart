import 'package:after_layout/after_layout.dart';
import 'package:task_management_app/global_provider/app_provider.dart';
import 'package:task_management_app/repository/authentication/auth_firebase.dart';
import 'package:task_management_app/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with AfterLayoutMixin, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    // controller.forward().then((value) {
    //   context.read<AppProvider>().init();
    // });
    context.read<AppProvider>().init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: AuthenticationFirebase.initializeFirebase(context: context),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("hasError");
          return Text("initializeFirebase error");
        } else if (snapshot.connectionState == ConnectionState.done) {
          print("has");
          return startScreenWidget();
        }
        // return CircularProgressIndicator(
        //   valueColor: AlwaysStoppedAnimation<Color>(
        //     Colors.red,
        //   ),
        // );
        return startScreenWidget();
      },
    );
  }

  Widget startScreenWidget() {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: OctoImage(
              image: AssetImage("assets/image/logo/24_hos_logo.png"),
              fit: BoxFit.fitWidth,
            ),
          ),
          Spacer(),
          SpinKitThreeBounce(
            color: AppColor.primaryColor,
            size: 60,
          ),
          Spacer(),
        ],
      ),
    );
  }
}
