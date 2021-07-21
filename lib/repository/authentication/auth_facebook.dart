// import 'package:task_management_app/utils/helper.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//
//
// class AuthenticationFacebook {
//   static Future<User> signInWithFacebook({@required BuildContext? context}) async {
//     User? user;
//     // try{
//       AccessToken? accessToken;
//       LoginResult loginResult = (await FacebookAuth.instance.login());
//       accessToken = loginResult.accessToken;
//
//       // AccessToken accessToken = (await FacebookAuth.instance.login());
//       final OAuthCredential credential = FacebookAuthProvider.credential(
//         accessToken!.token,
//       );
//
//       print("access token by caca: ${accessToken.toJson()} ");
//       final userData = await FacebookAuth.instance.getUserData();
//
//       final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//       user = userCredential.user;
//
//       String? photoUrl = "${user?.photoURL}?height=500&access_token=${accessToken.token}";
//
//       user?.updateProfile(photoURL: photoUrl);
//       Helper.showLoading();
//
//       return user!;
//
//     // }on FacebookAuthException catch (e) {
//     //   switch (e.errorCode) {
//     //     case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
//     //       print("You have a previous login operation in progress");
//     //       Helper.closeLoading();
//     //       break;
//     //     case FacebookAuthErrorCode.CANCELLED:
//     //       print("login cancelled");
//     //       Helper.closeLoading();
//     //       break;
//     //     case FacebookAuthErrorCode.FAILED:
//     //       print("login failed");
//     //       Helper.closeLoading();
//     //       break;
//     //   }
//     }
// }