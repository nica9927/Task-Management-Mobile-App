//
//
// import 'package:task_management_app/global_provider/app_provider.dart';
// import 'package:task_management_app/repository/authentication/auth_google.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';
//
// class AuthenticationFirebase {
//   static Future<FirebaseApp> initializeFirebase({
//   @required BuildContext? context
// }) async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//     User? user = FirebaseAuth.instance.currentUser;
//
//     if(user != null) {
//       print("Login User Already: $user");
//
//       var vm  = context?.read<AppProvider>();
//       vm?.user = user;
//     }
//     return firebaseApp;
//   }
//
//   static Future<void> signOut({@required BuildContext? context}) async {
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//     AccessToken? _accessToken;
//     User? user = FirebaseAuth.instance.currentUser;
//     try {
//       if (!kIsWeb) {
//         await googleSignIn.signOut();
//         await FacebookAuth.instance.logOut();
//         _accessToken = null;
//         user = null;
//         print("user: ${user}");
//       }
//       await FirebaseAuth.instance.signOut();
//       var vm = context!.read<AppProvider>();
//       vm.user = null;
//     } catch (e) {
//       ScaffoldMessenger.of(context!).showSnackBar(
//         AuthenticationGoogle.customSnackBar(
//           content: 'Error signing out. Try again.',
//         ),
//       );
//     }
//   }
// }