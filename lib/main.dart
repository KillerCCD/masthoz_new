import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashtoz_flutter/domens/blocs/Login/login_bloc.dart';
import 'package:mashtoz_flutter/domens/blocs/register_bloc/register_bloc.dart';
import 'package:mashtoz_flutter/domens/models/book_data/book_channgeNotifire.dart';
import 'package:mashtoz_flutter/domens/repository/user_data_provider.dart';
import 'package:mashtoz_flutter/test_screen.dart';
import 'package:mashtoz_flutter/ui/widgets/login_sign/forgot_screen/forgot_screen.dart';
import 'package:mashtoz_flutter/ui/widgets/login_sign/forgot_screen/resset_password_screen/resset_password_screen.dart';
import 'package:mashtoz_flutter/ui/widgets/login_sign/forgot_screen/verify_code_screen.dart/verify_code_screen.dart';
import 'package:mashtoz_flutter/ui/widgets/login_sign/login_screen/login_screen.dart';
import 'package:mashtoz_flutter/ui/widgets/login_sign/singup_screen/singup_screen.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/bottom_bars_pages/bottom_bar_menu_pages.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/bottom_bars_pages/search_page.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/home_screen.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/library_pages/book_inherited_widget.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/abaut_us.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/audio_library/audio_library.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/autio_librar_test.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/dialect/dialect.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/dictionary_screen/aarm_italy_dictionary.dart';
import 'package:provider/provider.dart';

import 'ui/widgets/main_page/main_menu_pages/dictionary_screen/dictionary.dart';
import 'ui/widgets/main_page/main_menu_pages/encyclopedia/encyclopedia.dart';
import 'ui/widgets/main_page/main_menu_pages/gallery/galery_item.dart';

void main() {
  runApp(const MyApp());
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
          ChangeNotifierProvider(create: (_) => ContentProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
  }
}
