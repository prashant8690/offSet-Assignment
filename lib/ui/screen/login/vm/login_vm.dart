import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:offsetfarm_assignment/core/utils/app_function.dart';

class LoginVm extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<User?> googleLogin() async {
    if (await checkConnection()) {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        return userCredential.user;
      } else {
        return null;
      }
    } else {
      flutterToast("Check Your Connection");
    }
    return null;
  }
}
