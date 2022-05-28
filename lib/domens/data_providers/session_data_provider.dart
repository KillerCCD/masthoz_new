import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class _Keys {
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
  static const expiresToken = 'expires_in';
  static const cutsomerId = 'customer_id';
  static const menuList = 'menu_list';
}

class SessionDataProvider {
  final _storage = SharedPreferences.getInstance();
  Future<void> setAccessToken(String value) async {
    final storage = await _storage;
    storage.setString(_Keys.accessToken, value);
  }

  Future<String?> readsAccessToken() async {
    final storage = await _storage;
    return storage.getString(_Keys.accessToken);
  }

  Future<void> setRefreshToken(String value) async {
    final storage = await _storage;
    storage.setString(_Keys.refreshToken, value);
  }

  Future<String?> readRefreshToken() async {
    final storage = await _storage;
    return storage.getString(_Keys.refreshToken);
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

  deleteAllToken() async {
    final storage = await _storage;
    storage.remove(_Keys.refreshToken);
    storage.remove(_Keys.accessToken);
  }

  void setRegtoken(token) {}
}
