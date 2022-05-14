import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class _Keys {
  static const regToken = 'token';
  static const expiresToken = 'expires_in';
  static const cutsomerId = 'customer_id';
  static const menuList = 'menu_list';
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

  Future<void> setToeknExpires(int value) async {
    final storage = await _storage;
    storage.setInt(_Keys.expiresToken, value);
  }

  Future<int?> readToeknExpires() async {
    final storage = await _storage;
    return storage.getInt(_Keys.expiresToken);
  }

  Future<void> setCustomerId(int value) async {
    final storage = await _storage;
    storage.setInt(_Keys.cutsomerId, value);
  }

  Future<int?> readCustomerId() async {
    final storage = await _storage;
    return storage.getInt(_Keys.cutsomerId);
  }

  Future<void> setShowMenuList(List<String> list) async {
    final storage = await _storage;
    storage.setStringList(_Keys.menuList, list);
  }

  Future<List<String>?> readShowMenuList() async {
    final storage = await _storage;
    return storage.getStringList(_Keys.menuList);
  }

  deleteRegToken() async {
    final storage = await _storage;
    return storage.remove(_Keys.regToken);
  }
}
