import 'dart:convert';

import 'package:mashtoz_flutter/domens/data_providers/session_data_provider.dart';

import '../../globals.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  final sessionDataProvider = SessionDataProvider();
  Future<bool> signUp(
      {required String email,
      required String password,
      required String fullName}) async {
    bool isSuscces = false;

    isSuscces = await createUserWithNAmeEmailAndPassword(
        email: email, password: password, fullName: fullName);

    return isSuscces;
  }

  Future<bool> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    bool isSuscces = false;
    try {
      isSuscces =
          await signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
    return isSuscces;
  }

  Future<void> logOut() async {
    try {
      await sessionDataProvider.deleteRegToken();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signInWithEmailAndPassword(
      {String? email, String? password}) async {
    var token = await sessionDataProvider.readToken();
    print(token);
    Map userData = {
      'email': email,
      'password': password,
    };
    try {
      var response = await http.post(
        Uri.parse(Api.loginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'access_token': 'Bearer $token'
        },
        body: jsonEncode(userData),
      );
      var body = jsonDecode(response.body);
      var data = body['data'];
      print(data);
      if (response.statusCode == 200) {
        print('success');
        return true;
      } else {
        print("failed");
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> createUserWithNAmeEmailAndPassword(
      {String? email, String? password, String? fullName}) async {
    Map userData = {
      'email': email,
      'password': password,
      'full_name': fullName,
    };
    // var token = await sessionDataProvider.gettRegtoken();
    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbWFzaHRvei5vcmdcL2FwaVwvdjFcL2xvZ2luIiwiaWF0IjoxNjQ3NjI2NDYyLCJleHAiOjE2NDc2MzAwNjIsIm5iZiI6MTY0NzYyNjQ2MiwianRpIjoiSWVQRUZ6cVFnRUxUaFhwZCIsInN1YiI6MjUsInBydiI6ImEzZDg2OGQ4OTEyOTZhZTMwNzM2NjJiMmYwMjRkY2Y2YzY3YjUzZmMiLCJyb2xlIjoiY3VzdG9tZXIifQ.4K5NQ7rIXFvwLVGaySPopyniR_oiycBwzxeSMP_6eg8";
    print('$token object');

    try {
      var response = await http.post(
        Uri.parse(Api.resgisterUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData),
      );
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var token = body['access_token'];
        sessionDataProvider.setRegtoken(token);

        return true;
      } else {
        print("failed");
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> forgotPasswordPost(String email, Function closure) async {
    Map userEmail = {'email': email};

    try {
      var response = await http.post(
        Uri.parse(Api.forgotPassword),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userEmail),
      );
      var data = jsonDecode(response.body);
      closure(data['success']);
      // if (response.statusCode == 200) {
      //   return true;
      // } else {
      //   print("failed");
      //   return false;
      // }
    } catch (e) {
      print(e);
    }
    return false;
  }

  void sendCode(String email, Function closure) async {
    Map userEmail = {'email': email};
    try {
      final response = await http.post(
        Uri.parse(Api.checkCode),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(userEmail),
      );
      print(response.body);
      var data = jsonDecode(response.body);
      closure(data['succes']);
    } catch (error) {
      print(error);
    }
  }
}
