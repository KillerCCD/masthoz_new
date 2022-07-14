import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FocuseDay extends ChangeNotifier {
  var _focusDays = DateTime.now().day.toInt();
  int get day => _focusDays;
  void setDays(int days) {
    _focusDays = days;

    notifyListeners();
  }
}
