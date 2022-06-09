import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mashtoz_flutter/domens/blocs/Login/login_bloc.dart';
import 'package:mashtoz_flutter/domens/blocs/register_bloc/register_bloc.dart';
import 'package:mashtoz_flutter/domens/models/app_theme.dart/theme_notifire.dart';

import 'package:mashtoz_flutter/domens/models/user_sign_or_not.dart';

import 'package:mashtoz_flutter/domens/repository/user_data_provider.dart';

import 'package:mashtoz_flutter/ui/widgets/main_page/home_screen.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/library_pages/book_inherited_widget.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          ChangeNotifierProvider<ContentProvider>(
              create: (_) => ContentProvider()),
          ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
          ChangeNotifierProvider<UserInfoNotify>(
              create: (_) => UserInfoNotify())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/images/surb-hogi.svg'),
        ],
      ),
      nextScreen: HomeScreen(),
      backgroundColor: Color.fromRGBO(83, 66, 77, 1),
      duration: 3000,
      splashTransition: SplashTransition.rotationTransition,
    );
  }
}
//  BookReadScreen(
//             readScreen: Content(
//                 id: 1,
//                 title: 'DAsdsd',
//                 image: 'asdf/',
//                 body: 'okdofkdoklkdlfkdlfkdlfkdlfkldfk',
//                 videoLink: '',
//                 explanation: 'ikilikikdkfdf',
//                 author: 'dasdsaidonf',
//                 content: null),
//           ),