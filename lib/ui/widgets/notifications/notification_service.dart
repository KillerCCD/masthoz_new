import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(" --- background message received ---");
  print(message.notification!.title);
  print(message.notification!.body);
}

class NotificationService {
  factory NotificationService() {
    return _notificationService;
  }
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationService._internal();

  static const channelId = '123';

  String? selectedNotificationPayload;

  //NotificationService a singleton object
  static final NotificationService _notificationService =
      NotificationService._internal();

  static AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    'channel ID',
    'channel name',
    channelDescription: 'channel description',
    icon: '@mipmap/ic_launcher',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  static void initialize(BuildContext context) async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? route) async {
      if (route != null) {
        Navigator.of(context).pushNamed(route);
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    tz.initializeTimeZones();

    Future<void> showNotifications() async {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: _androidNotificationDetails,
            ),
          );
        }
      });
      await flutterLocalNotificationsPlugin.show(
        0,
        "Notification Title",
        "This is the Notification Body!",
        NotificationDetails(android: _androidNotificationDetails),
      );
    }
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "mashtoz",
        "mashtoz channel",
        channelDescription: "this is our channel",
        importance: Importance.max,
        priority: Priority.high,
      ));

      await flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data["route"],
      );
    } on Exception catch (e) {
      print(e);
    }
  }

// Future selectNotification(String payload) async {
//   if (payload != null) {
//     debugPrint('notification payload: $payload');
//   }
//   await Navigator.push(
//     context,
//     MaterialPageRoute<void>(builder: (context) => SecondScreen()),
//   );
// }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('data'),
      ),
    );
  }
}
