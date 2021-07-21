import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:task_management_app/constants/props.dart';
import 'package:task_management_app/style/color.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';

class Helper {
  static showLoading() {
    BotToast.showCustomLoading(
        backButtonBehavior: BackButtonBehavior.ignore,
        toastBuilder: (void Function() cancelFunc) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SpinKitThreeBounce(color: AppColor.primaryColor),
          ],
        ));
  }

  static closeLoading() => BotToast.closeAllLoading();

  static Future<File?> compressImageAndGetFile({File? file, Uint8List? uint8list, bool justConvert = false, bool isPNG = false, int? quality, int? minWidth}) async {
    Directory tempDir = await getTemporaryDirectory();
    String path = tempDir.path + "temp-image-aoh${DateTime.now().millisecondsSinceEpoch}.${isPNG ? "png" : "jpg"}";

    String pathOriginal = tempDir.path + "${DateTime.now().millisecondsSinceEpoch}.${isPNG ? "png" : "jpg"}";
    if (file == null) file = await File(pathOriginal).writeAsBytes(uint8list!.buffer.asUint8List(uint8list.offsetInBytes, uint8list.lengthInBytes));
    if (isPNG) return file;
    File? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      path,
      minWidth: minWidth ?? 1000,
      quality: justConvert ? 100 : quality ?? 88,
    );
    return result;
  }

  static void showMessage({
    bool isSuccess = true,
    String? message,
    String? title,
    Color? color,
  }) =>
      isSuccess ? showMessageSuccess(title: title ?? "Success", message: message ?? "Success", color: color) : showMessageError(title: title ?? "Error", message: message ?? "Error");

  static void showMessageSuccess({String title = "Successful", String message = "Success", Color? color}) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 2),
      enableKeyboardSafeArea: true,
      enableSlideOff: true,
      crossPage: true,
      onlyOne: true,
      dismissDirections: [],
      backButtonBehavior: BackButtonBehavior.ignore,
      wrapToastAnimation: (controller, cancelFunc, widget) {
        return FadeScaleTransition(
          animation: CurvedAnimation(
            parent: controller,
            curve: Curves.fastOutSlowIn,
            reverseCurve: Curves.fastOutSlowIn,
          ),
          child: widget,
        );
      },
      toastBuilder: (cancelFunc) => GestureDetector(onTap: cancelFunc, child: _alertWidget(color: color ?? Colors.green, message: message, title: title)),
    );
  }

  static void showMessageError({String title = "Error", String? message = "Error"}) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 2),
      enableKeyboardSafeArea: true,
      enableSlideOff: true,
      crossPage: true,
      onlyOne: true,
      dismissDirections: [],
      backButtonBehavior: BackButtonBehavior.ignore,
      wrapToastAnimation: (controller, cancelFunc, widget) {
        return FadeScaleTransition(
          animation: CurvedAnimation(
            parent: controller,
            curve: Curves.fastOutSlowIn,
            reverseCurve: Curves.fastOutSlowIn,
          ),
          child: widget,
        );
      },
      toastBuilder: (cancelFunc) => GestureDetector(onTap: cancelFunc, child: _alertWidget(color: Colors.redAccent, message: message, title: title)),
    );
  }

  static Future<T?> showDialog<T>({Widget? dialog, bool barrierDismissible = true, required BuildContext context, TickerProvider? vsync}) {
    return showGeneralDialog<T>(
      barrierDismissible: barrierDismissible,
      useRootNavigator: true,
      // routeSettings: ,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: dialog);
      },
      context: context,
      // ?? locator<NavigationService>().context,
      barrierColor: Colors.black38,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: Duration(milliseconds: 250),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        if (vsync != null)
          return AnimatedSize(
            vsync: vsync,
            duration: Duration(milliseconds: 750),
            child: dialog,
          );
        else
          return dialog!;
      },
    );
  }

  static Future<bool> askDialog<T>({
    required BuildContext context,
    required String title,
    String? content,
    String? yes,
    String? no,
  }) async {
    var r = await Helper.showDialog<bool>(
      context: context,
      dialog: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          title,
        ),
        content: content != null ? Text("${content}") : null,
        actions: [
          FlatButton(
            shape: StadiumBorder(),
            onPressed: () => Modular.to.pop(false),
            textColor: Colors.grey,
            child: Text(no ?? "NO"),
          ),
          SizedBox(width: 8),
          FlatButton(
            shape: StadiumBorder(),
            onPressed: () => Modular.to.pop(true),
            textColor: Colors.deepOrange,
            child: Text(yes ?? "YES"),
          ),
        ],
      ),
    );
    return r ?? false;
  }

  static Stream<Duration> counter(Duration maxDuration, {VoidCallback? onSuccess}) {
    late StreamController<Duration> controller;
    Timer? timer;
    Duration counter = Duration();

    //ฟังก์ชันสำหรับเริ่มรับเลข
    void startTimer() {
      timer = Timer.periodic(
        Duration(seconds: 1),
            (_) {
          counter += Duration(seconds: 1);
          controller.add((maxDuration - counter));
          if (counter >= maxDuration) {
            timer!.cancel();
            controller.close();
          }
        },
      );
    }

    //ฟังก์ชันสำหรับหยุดนับเลข
    void stopTimer() {
      if (timer != null) {
        timer!.cancel();
        timer = null;
      }
    }

    controller = StreamController<Duration>(
      //เริ่มทำงาน startTimer() เมื่อ listen นะ
      onListen: startTimer,

      // onPause:(){
      //   stopTimer();
      //   if(onSuccess != null) onSuccess();
      // },
      onPause: stopTimer,
      onResume: startTimer,
      onCancel: () {
        stopTimer();
        if (onSuccess != null) onSuccess();
      },
    );

    return controller.stream;
  }

  static Container buildDismiss({Color? color, IconData? icon, String? title, isFlip = false}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: isFlip ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: isFlip
            ? [
          Text(
            title!,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ].reversed.toList()
            : [
          Text(
            title!,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  static Future<T?> showDialogEditValue<T>({
    String? title,
    String? initValue,
    bool barrierDismissible = true,
    required BuildContext context,
    FormFieldValidator? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    T Function(String value)? onParseValue,
  }) {
    return showDialog<T>(
      barrierDismissible: barrierDismissible,
      context: context,
      dialog: StatefulBuilder(
        builder: (context, setState) {
          var c = TextEditingController(text: initValue);
          var form = GlobalKey<FormState>();
          return Dialog(
            child: Container(
              width: 400,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Form(
                    key: form,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      validator: validator,
                      controller: c,
                      keyboardType: keyboardType,
                      inputFormatters: inputFormatters,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.grey[100],
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: () => Navigator.pop(context),
                        textColor: Colors.red,
                        child: Text("NO"),
                      ),
                      FlatButton(
                        onPressed: () {
                          if (form.currentState!.validate())
                            Navigator.pop(
                              context,
                              onParseValue == null ? c.text : onParseValue(c.text),
                            );
                        },
                        child: Text("YES"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget _alertWidget({
    String? message,
    required String title,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              boxShadow: boxElevation,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    Icons.notifications_active,
                    size: 65,
                    color: color.withOpacity(1.0),
                  ),
                ),
                Flexible(
                  child: Container(
                    child: AutoSizeText(
                      "$message",
                      // textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


