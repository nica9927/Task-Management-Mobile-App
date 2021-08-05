import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import 'package:task_management_app/screen/main/chat/chat_provider.dart';
import 'package:task_management_app/style/color.dart';
import 'package:task_management_app/widget/custom_widget/custom_background.dart';
import 'package:task_management_app/widget/custom_widget/custom_container.dart';
import 'package:task_management_app/widget/custom_widget/custom_icon.dart';
import 'package:task_management_app/widget/custom_widget/custom_profile_image.dart';
import 'package:task_management_app/widget/custom_widget/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/widget/my_text_form_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with AfterLayoutMixin {
  StreamSubscription? _someSubscription;
  final msg = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController = ScrollController();

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    var vm = context.read<ChatProvider>();
    await vm.createDialog();
    vm.subscribe(_someSubscription);
    keyRefresh.currentState?.show();
  }

  // @override
  // void initState() {
  //   var vm = context.read<ChatProvider>();
  //   vm.subscribe(_someSubscription);
  //   super.initState();
  // }

  @override
  void dispose() {
    _someSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, vm, child) {
        return Scaffold(
          body: CustomBackground(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Modular.to.pop(),
                              child: CustomIcon(
                                icon: FontAwesomeIcons.arrowLeft,
                                iconColor: AppColor.primaryColor,
                                iconSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomProfileImage(
                              height: 35,
                              width: 35,
                              photoPath:
                                  "https://www.tvpoolonline.com/wp-content/uploads/2020/04/1586886218573.jpg",
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "${vm.opponentName ?? ""}",
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  text: "Active Now",
                                  color: Colors.black54,
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomIcon(
                              icon: FontAwesomeIcons.phoneAlt,
                              iconColor: AppColor.primaryColor,
                              iconSize: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomIcon(
                              icon: FontAwesomeIcons.video,
                              iconColor: AppColor.primaryColor,
                              iconSize: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 85,
                    child: RefreshIndicator(
                      key: keyRefresh,
                      onRefresh: () async {
                       await vm.receiveMsg();
                       Timer(
                           Duration(milliseconds: 100),
                               () => _scrollController.jumpTo(
                               _scrollController
                                   .position.maxScrollExtent));
                      } ,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: vm.messages.length,
                        itemBuilder: (context, index) {
                          var item = vm.messages[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomContainer(
                                  child: CustomText(
                                    text: "${item?.body ?? ""}",
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                ),
                                CustomProfileImage(
                                  height: 25,
                                  width: 25,
                                  photoPath:
                                      "https://static.wikia.nocookie.net/drama/images/7/77/Baifern_Pimchanok_Luevisadpaibul.png/revision/latest?cb=20200114161218",
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 15,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                        key: formKey,
                        child: Row(
                          children: [
                            Expanded(
                              child: MyTextFormField(
                                color: Colors.white,
                                controller: msg,
                                onSaved: (newValue) => vm.body = newValue,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                formKey.currentState!.save();
                                msg.clear();
                                await vm.sendMsg();
                                await vm.receiveMsg();
                                Timer(
                                    Duration(milliseconds: 100),
                                    () => _scrollController.jumpTo(
                                        _scrollController
                                            .position.maxScrollExtent));
                              },
                              child: CustomIcon(
                                icon: FontAwesomeIcons.solidPaperPlane,
                                iconColor: Colors.pinkAccent,
                              ),
                            )
                          ],
                        ),
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
