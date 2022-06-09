import 'dart:convert';

import 'package:mashtoz_flutter/domens/data_providers/session_data_provider.dart';
import 'package:mashtoz_flutter/domens/models/user.dart';
import 'package:mashtoz_flutter/domens/models/user_sign_or_not.dart';

import '../../globals.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  final sessionDataProvider = SessionDataProvider();

  //Sign Up
  Future<bool> signUp(
      {required String email,
      required String password,
      required String fullName}) async {
    bool isSuscces = false;

    isSuscces = await createUserWithNAmeEmailAndPassword(
        email: email, password: password, fullName: fullName);

    return isSuscces;
  }

  //Login
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

  //Log out
  Future<void> logOut() async {
    try {
      await sessionDataProvider.deleteAllToken();
    } catch (e) {
      print(e);
    }
  }

  //Login
  Future<bool> signInWithEmailAndPassword(
      {String? email, String? password}) async {
    Map userData = {
      'email': email,
      'password': password,
    };

    try {
      var response = await http.post(
        Uri.parse(Api.loginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );
      var body = jsonDecode(response.body);
      var token = body['access_token'];
      print(token);
      if (response.statusCode == 200) {
        print('success');
        var access_token = body['access_token'];
        var refresh_token = body['refresh_token'];
        sessionDataProvider.setAccessToken(access_token);
        sessionDataProvider.setRefreshToken(refresh_token);
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

  //Signup
  Future<bool> createUserWithNAmeEmailAndPassword(
      {String? email, String? password, String? fullName}) async {
    Map userData = {
      'email': email,
      'password': password,
      'full_name': fullName,
    };
    // var token = await sessionDataProvider.gettRegtoken();
    // var token =
    //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbWFzaHRvei5vcmdcL2FwaVwvdjFcL2xvZ2luIiwiaWF0IjoxNjQ3NjI2NDYyLCJleHAiOjE2NDc2MzAwNjIsIm5iZiI6MTY0NzYyNjQ2MiwianRpIjoiSWVQRUZ6cVFnRUxUaFhwZCIsInN1YiI6MjUsInBydiI6ImEzZDg2OGQ4OTEyOTZhZTMwNzM2NjJiMmYwMjRkY2Y2YzY3YjUzZmMiLCJyb2xlIjoiY3VzdG9tZXIifQ.4K5NQ7rIXFvwLVGaySPopyniR_oiycBwzxeSMP_6eg8";
    //print('$token object');

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
        var access_token = body['access_token'];
        var refresh_token = body['refresh_token'];
        sessionDataProvider.setAccessToken(access_token);
        sessionDataProvider.setRefreshToken(refresh_token);

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

  //Forgot Password post
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
      var message = data['message'];
      if (response.statusCode == 200 && message.contains('passwords.sent')) {
        closure(true);
      } else {
        closure(false);
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  //Send Code for password_resset
  void sendCode(String code, Function closure) async {
    Map smsCode = {'code': code};
    try {
      final response = await http.post(
        Uri.parse(Api.checkCode),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(smsCode),
      );
      var body = json.decode(response.body);
      //var responseCode = body['code'];
      var message = body['message'];
      print(response.body);
      if (response.statusCode == 200 &&
          message.toString().contains('Password reset code is valid')) {
        closure(true);
      } else {
        closure(false);
      }
    } catch (error) {
      print(error);
    }
  }

  //Password Resset
  Future<bool> passwordReset(
      {required String code,
      required String password,
      required String passwordConfirm,
      Function? closure}) async {
    Map resetPassword = {
      'code': code,
      'password': password,
      'password_confirmation': passwordConfirm
    };

    try {
      var response = await http.post(
        Uri.parse(Api.resetPassword),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(resetPassword),
      );

      if (response.statusCode == 200) {
        closure!(true);
      } else {
        closure!(false);
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  //Fetch User Info
  Future<User> fetchUserInfo() async {
    var token = await sessionDataProvider.readsAccessToken();
    var user;
    try {
      var response = await http.get(
        Uri.parse(Api.userInfo),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer $token'
        },
      );
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('success');
        Map.from(body).forEach((key, value) {
          user = User.fromJson(value);
        });
        return user;
      } else if (response.statusCode == 401) {
        bool isTrue = await refreshToken();
        if (isTrue) {
          fetchUserInfo();
        }
        ;
      } else {
        print("failed");
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  //Contact Form
  Future<bool> userContactForm(Map parameters) async {
    try {
      var response = await http.post(
        Uri.parse(Api.contactform),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(parameters),
      );
      var success = json.decode(response.body)['success'];
      if (response.statusCode == 200 && success == true) {
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

//Get Favorites
  Future<List<dynamic>> getFavorites() async {
    var token = await sessionDataProvider.readsAccessToken();
    try {
      var response = await http.get(
        Uri.parse(Api.getFavorites),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token'
        },
      );
      //var success = json.decode(response.body);
      if (response.statusCode == 200) {
        print('success');
      } else if (response.statusCode == 401) {
        bool isTrue = await refreshToken();
        isTrue ? print(true) : print(false);
      } else {
        print("failed");
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  //Save Favorite
  Future<bool> saveFavorite(Map parameters) async {
    var token = await sessionDataProvider.readsAccessToken();
    try {
      var response = await http.post(
        Uri.parse(Api.saveFavorite),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer $token'
        },
        body: json.encode(parameters),
      );

      if (response.statusCode == 200) {
        print('success');
        return true;
      } else if (response.statusCode == 401) {
        bool isTrue = await refreshToken();

        if (isTrue) {
          saveFavorite(parameters);
          return true;
          //  UsersIsSign(true);
        } else {
          return false;
        }
      } else {
        print("failed");
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  //Delete Favorite
  Future<bool> deleteFavorite(Map parameters) async {
    try {
      var response = await http.delete(
        Uri.parse(Api.contactform),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(parameters),
      );
      var success = json.decode(response.body)['success'];
      if (response.statusCode == 200 && success == true) {
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

  Future<bool> refreshToken() async {
    final refresh_token = await sessionDataProvider.readRefreshToken();
    final access_token = await sessionDataProvider.readsAccessToken();
    if (refresh_token != null) {
      try {
        final response = await http.post(Uri.parse(Api.refreshToken), headers: {
          'Authorization': 'bearer $access_token',
          'Contnet-type': "application/json"
        }, body: <String, dynamic>{
          'refresh_token': '$refresh_token',
        });
        ;
        var body = jsonDecode(response.body);

        if (response.statusCode == 200) {
          var access_token = body['access_token'];

          sessionDataProvider.setAccessToken(access_token);

          return true;
        } else {
          sessionDataProvider.deleteAllToken();
          return false;
        }
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }
}
