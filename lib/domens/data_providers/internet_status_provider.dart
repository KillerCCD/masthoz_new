import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NetworkStatusService {
  static String status = " ";

  static late StreamSubscription subscription;

  static Future<void> checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.mobile) {
      status = "Mobile Network";
    } else if (result == ConnectivityResult.wifi) {
      status = "WiFi Network";
    }
  }

  static void initila(BuildContext context) async {
    subscription = Connectivity().onConnectivityChanged.listen(
      (result) {
        Fluttertoast.showToast(
            msg: result.name,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      },
    );
    // showSimpleNotification(
    //   Text('Internet Connectivity Update'),
    //   subtitle: Text(result.name),
    //   background: Colors.amber,
    // );
  }
}

  // static void showConnectivitySnackBar(ConnectivityResult result) {

  // }

