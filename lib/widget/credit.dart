import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

class Credit extends StatefulWidget {
  final Color color;

  const Credit({Key? key, this.color = Colors.white}) : super(key: key);

  @override
  _CreditState createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: OctoImage(
              image: AssetImage("assets/image/logo/fintech_logo.png"),
            ),
          ),
          Opacity(
              opacity: 0.7,
              child: Text(
                "© 2019 Fintechinno Co.,Ltd. All rights reserved",
                style: TextStyle(color: widget.color),
              )),
        ],
      ),
    );
  }
}
