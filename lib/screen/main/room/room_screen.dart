import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:task_management_app/global_provider/app_provider.dart';
import 'package:task_management_app/modules/router.dart';
import 'package:task_management_app/screen/main/home/home_provider.dart';
import 'package:task_management_app/screen/main/room/room_provider.dart';
import 'package:task_management_app/style/color.dart';
import 'package:task_management_app/widget/custom_widget/custom_appbar.dart';
import 'package:task_management_app/widget/custom_widget/custom_background.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/widget/custom_widget/custom_container.dart';
import 'package:task_management_app/widget/custom_widget/custom_icon.dart';
import 'package:task_management_app/widget/custom_widget/custom_profile_image.dart';
import 'package:task_management_app/widget/custom_widget/custom_text.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> with AfterLayoutMixin {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    context.read<RoomProvider>().isConnected();
    keyRefresh.currentState!.show();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<AppProvider>().qbUser;
    return Consumer<RoomProvider>(
      builder: (context, vm, child) {
        return Scaffold(
          body: CustomBackground(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: vm.connected ? Colors.green : Colors.red),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: (){
                                Modular.to.pushNamed(AppRouter.fromModule().agoraChat);
                              },
                              child: CustomText(
                                text: "Hi!, ${user?.fullName ?? ""}",
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                           await vm.logout();
                            Modular.to.pushNamed(AppRouter.fromModule().home);
                          },
                          child: CustomIcon(
                            icon: FontAwesomeIcons.signOutAlt,
                            iconSize: 20,
                            iconColor: AppColor.primaryColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        key: keyRefresh,
                        onRefresh: () => vm.getUsers(),
                        child: ListView.builder(
                          itemCount: vm.listUser.length,
                          itemBuilder: (context, index) {
                            var item = vm.listUser[index];
                            return GestureDetector(
                              onTap: () {
                                Modular.to.pushNamed(
                                    AppRouter.fromModule().chat,
                                    arguments: {
                                      "userId": user?.id,
                                      "opponentId": item?.id,
                                      "opponentName": "${item?.fullName}",
                                    });
                              },
                              child: CustomContainer(
                                bgColor: Colors.white.withOpacity(0.5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomProfileImage(
                                      height: 40,
                                      width: 40,
                                      photoPath:
                                          "https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png",
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    CustomText(
                                      text: "${item?.fullName}",
                                      fontSize: 16,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
