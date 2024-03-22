import 'package:flutter/material.dart';
import 'package:oson_market/screens/home/home_screen.dart';
import 'package:oson_market/screens/profile/profile_screen.dart';

class BottomViewModel with ChangeNotifier {
  int _currentIndex = 0;

  final List<Widget> screens = [const HomeScreen(), const ProfileScreen()];

  int get currentIndex => _currentIndex;

  setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
