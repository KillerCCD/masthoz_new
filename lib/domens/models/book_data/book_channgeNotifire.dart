import 'package:flutter/material.dart';

class BookNotifire extends ChangeNotifier {
  String? __firstCharacterAudioLib;
  String? _firstCharacterDialect;

  String get firstCharactersDialect => _firstCharacterDialect!;

  String get firstCharactersAudioLib => __firstCharacterAudioLib!;

  void charactersSetDialect(var characters) {
    _firstCharacterDialect = characters;
    notifyListeners();
  }

  void charactersSetAudioLib(var characters) {
    __firstCharacterAudioLib = characters;
    notifyListeners();
  }

  void resetDatas() {
    __firstCharacterAudioLib = '';
    _firstCharacterDialect = '';
  }
}
