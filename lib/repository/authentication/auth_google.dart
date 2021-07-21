// import 'package:task_management_app/global_provider/app_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';
//
// class AuthenticationGoogle {
//   // Future<UserCredential> signInWithGoogle() async {
//   //
//   //
//   //
//   //   // Trigger the authentication flow
//   //   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
//   //
//   //   // Obtain the auth details from the request
//   //   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//   //
//   //   // Create a new credential
//   //   final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//   //     accessToken: googleAuth.accessToken,
//   //     idToken: googleAuth.idToken,
//   //   );
//   //   User user = FirebaseAuth.instance.currentUser;
//   //   print("user --- $user");
//   //
//   //   // Once signed in, return the UserCredential
//   //   return await FirebaseAuth.instance.signInWithCredential(credential);
//   //
//   //
//   //
//   // }
//   static SnackBar customSnackBar({@required String? content}) {
//     return SnackBar(
//       backgroundColor: Colors.black,
//       content: Text(
//         content!,
//         style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
//       ),
//     );
//   }
//
//   static Future<User?>? signInWithGoogle({@required BuildContext? context}) async {
//     var vm = context!.read<AppProvider>();
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;
//
//     if (kIsWeb) {
//       GoogleAuthProvider authProvider = GoogleAuthProvider();
//
//       try {
//         final UserCredential userCredential = await auth.signInWithPopup(authProvider);
//
//         user = userCredential.user;
//
//
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       final GoogleSignIn googleSignIn = GoogleSignIn();
//
//       final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );
//
//         try {
//           final UserCredential userCredential = await auth.signInWithCredential(credential);
//
//           print("access token by caca: ${googleSignInAuthentication.accessToken} ");
//
//           user = userCredential.user;
//           vm.photo = user?.photoURL;
//         } on FirebaseAuthException catch (e) {
//           if (e.code == 'account-exists-with-different-credential') {
//             ScaffoldMessenger.of(context).showSnackBar(
//               AuthenticationGoogle.customSnackBar(
//                 content: 'The account already exists with a different credential',
//               ),
//             );
//           } else if (e.code == 'invalid-credential') {
//             ScaffoldMessenger.of(context).showSnackBar(
//               AuthenticationGoogle.customSnackBar(
//                 content: 'Error occurred while accessing credentials. Try again.',
//               ),
//             );
//           }
//         } catch (e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             AuthenticationGoogle.customSnackBar(
//               content: 'Error occurred using Google Sign In. Try again.',
//             ),
//           );
//         }
//       }
//
//       return user;
//     }
//   }
//
// }