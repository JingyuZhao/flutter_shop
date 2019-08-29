import 'package:flutter/widgets.dart';

class CurrtentIndexProvide with ChangeNotifier {
  int currentIndex = 0;
  changeIndex(int nowIndex) {
    currentIndex = nowIndex;
    notifyListeners();
  }
}
