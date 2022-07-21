import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mashtoz_flutter/domens/blocs/Login/login_bloc.dart';
import 'package:mashtoz_flutter/domens/blocs/register_bloc/register_bloc.dart';
import 'package:mashtoz_flutter/domens/models/app_theme.dart/theme_notifire.dart';
import 'package:mashtoz_flutter/domens/models/bottom_bar_color_notifire.dart';

import 'package:mashtoz_flutter/domens/models/user_sign_or_not.dart';

import 'package:mashtoz_flutter/domens/repository/user_data_provider.dart';
import 'package:mashtoz_flutter/firebase_options.dart';
import 'package:mashtoz_flutter/ui/utils/day_change_notifire.dart';
import 'package:mashtoz_flutter/ui/utils/splash_screen.dart';

import 'package:mashtoz_flutter/ui/widgets/main_page/bottom_bars_pages/bottom_bar_menu_pages.dart';

import 'package:mashtoz_flutter/ui/widgets/main_page/library_pages/book_inherited_widget.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/library_pages/book_page.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/audio_library/audio_library.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/dialect/dialect.dart';

import 'package:provider/provider.dart';

import 'domens/models/book_data/book_channgeNotifire.dart';
import 'ui/widgets/main_page/main_menu_pages/encyclopedia/encyclopedia.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  // NotificationService().init();
  //await execute(InternetConnectionChecker());
  WidgetsFlutterBinding.ensureInitialized();

  CacheManager.logLevel = CacheManagerLogLevel.verbose;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  Widget build(BuildContext context) {
    final user = UserDataProvider();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => LoginCubit(user)),
        BlocProvider<RegisterCubit>(create: (_) => RegisterCubit(user)),
      ],
      child: MultiProvider(
        providers: [
          Provider<UserDataProvider>(
            create: (_) => UserDataProvider(auth: FirebaseAuth.instance),
          ),
          ChangeNotifierProvider<ContentProvider>(
              create: (_) => ContentProvider()),
          ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
          ChangeNotifierProvider<UserInfoNotify>(
              create: (_) => UserInfoNotify()),
          ChangeNotifierProvider<BottomColorNotifire>(
              create: (_) => BottomColorNotifire()),
          ChangeNotifierProvider<BookNotifire>(create: (_) => BookNotifire()),
          ChangeNotifierProvider<FocuseDay>(create: (_) => FocuseDay()),
        ],
        child: MaterialApp(
          locale: _locale,
          debugShowCheckedModeBanner: false,
          home: const MySplashScreen(),
          // builder: (context, child) {
          //   return HomeScreen();
          // },
          routes: {
            "lessons": (_) => const ItalianPage(),
            "libraries": (_) => const BookInitalScreen(),
            "encyclopedias": (_) => const Ecyclopedia(),
            "audiolibraries": (_) => const AudioLibrary(),
            "dialects": (_) => const Dialect(),
          },
        ),
      ),
    );
  }
}
