import 'package:flutter/material.dart';

class DialogInternetConnection extends StatefulWidget {
  @override
  _DialogInternetConnectionState createState() => _DialogInternetConnectionState();
}

class _DialogInternetConnectionState extends State<DialogInternetConnection> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.network_check_rounded,
              size: 200,
              color: Colors.orange,
            ),
            Text(
              "No Internet Connection",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Your not connected to the internet.\nMake sure Wi-Fi is on, Airplane Mode is off\nand try again",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
