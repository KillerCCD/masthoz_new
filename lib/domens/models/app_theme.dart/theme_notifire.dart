import 'package:flutter/material.dart';
import 'package:mashtoz_flutter/config/palette.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData? _themeData;

  get theme => _themeData;
  get lightTheme => ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Palette.labelText),
      );
  void lightThemeData() {
    _themeData = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
          .copyWith(secondary: Palette.labelText),
    );
    notifyListeners();
  }

  void darkThemeData() {
    _themeData = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
          .copyWith(secondary: Palette.main),
    );
    notifyListeners();
  }
}
