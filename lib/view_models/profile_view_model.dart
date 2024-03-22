import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oson_market/screens/routes.dart';

class ProfileViewModel extends ChangeNotifier {
  bool isDark = false;
  bool isLoading = false;
  init() async {
    isDark = await AdaptiveTheme.getThemeMode() == AdaptiveThemeMode.dark;
  }

  setTheme({required bool value, required BuildContext context}) {
    isDark = value;
    if (isDark) {
      AdaptiveTheme.of(context).setDark();
    } else {
      AdaptiveTheme.of(context).setLight();
    }
    notifyListeners();
  }
  logout(BuildContext context) async {
    _notify(true);
    await FirebaseAuth.instance.signOut();
    _notify(false);
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, RoutesNames.login);
  }
  updateUsername(String username, BuildContext context) async {
    _notify(true);
    await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
    _notify(false);
    if(!context.mounted) return;
    Navigator.pop(context);
  }

  _notify(bool v) {
    isLoading = v;
    notifyListeners();
  }
}
