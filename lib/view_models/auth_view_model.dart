import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oson_market/screens/routes.dart';
import 'package:oson_market/utils/images/app_images.dart';
import 'package:oson_market/utils/utility_function.dart';
import 'package:oson_market/utils/validates/app_validates.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool isSwitching = false;

  bool get loading => _isLoading;

  User? get getUser => FirebaseAuth.instance.currentUser;
  List<String> iconList = [
    AppImages.googleIcon,
    AppImages.appleIcon,
    AppImages.facebookIcon
  ];

  switchOnChange(bool value) {
    isSwitching = value;
    notifyListeners();
  }

  registerUser(
    BuildContext context, {
    required String email,
    required String password,
    required String username,
  }) async {
    if (AppValidates.emailExp.hasMatch(email) &&
        AppValidates.passwordExp.hasMatch(password)) {
      try {
        _notify(true);
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
        }
        _notify(false);
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, RoutesNames.bottomAppBar);
      } on FirebaseAuthException catch (e) {
        if (!context.mounted) return;
        showErrorForRegister(e.code, context);
      } catch (error) {
        if (!context.mounted) return;
        showSneckbar(
          context: context,
          message: "Noma'lum xatolik yuz berdi:$error.",
        );
      }
    } else {
      showSneckbar(
        context: context,
        message: "Login yoki Parolni xato kiritdingiz!",
      );
    }
  }

  login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    if (AppValidates.emailExp.hasMatch(email) &&
        AppValidates.passwordExp.hasMatch(password)) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, RoutesNames.bottomAppBar);
      } on FirebaseAuthException catch (err) {
        if (!context.mounted) return;
        showErrorForLogin(err.code, context);
      } catch (error) {
        if (!context.mounted) return;
        showSneckbar(
          context: context,
          message: "Noma'lum xatolik yuz berdi:$error.",
        );
      }
    } else {
      showSneckbar(
        context: context,
        message: "Login yoki Parolni xato kiritdingiz!",
      );
    }
  }

  updateImageUrl(String imagePath) async {
    _notify(true);
    try {
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(imagePath);
    } catch (error) {
      debugPrint("ERROR:$error");
    }
    _notify(false);
  }

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<void> signInWithGoogle(BuildContext context,
      [String? clientId]) async {
    _notify(true);

    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(clientId: clientId).signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    _notify(false);
    if (userCredential.user != null) {
      Navigator.pushReplacementNamed(context, RoutesNames.bottomAppBar);
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
