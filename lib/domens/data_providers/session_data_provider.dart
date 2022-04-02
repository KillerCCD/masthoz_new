import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class _Keys {
  static const regToken = 'token';
}

class SessionDataProvider {
  final _storage = SharedPreferences.getInstance();
  Future<void> setRegtoken(String value) async {
    final storage = await _storage;
    storage.setString(_Keys.regToken, value);
  }

  Future<String?> readToken() async {
    final storage = await _storage;
    return storage.getString(_Keys.regToken);
  }

  deleteRegToken() async {
    final storage = await _storage;
    return storage.remove(_Keys.regToken);
  }
}
