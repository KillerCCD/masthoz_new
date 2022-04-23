import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashtoz_flutter/domens/blocs/Login/login_bloc.dart';
import 'package:mashtoz_flutter/domens/blocs/register_bloc/register_bloc.dart';
import 'package:mashtoz_flutter/domens/repository/user_data_provider.dart';
import 'package:mashtoz_flutter/test_screen.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/home_screen.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/abaut_us.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/audio_library/audio_library.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/autio_librar_test.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/dialect/dialect.dart';
import 'package:mashtoz_flutter/ui/widgets/main_page/main_menu_pages/dictionary_screen/aarm_italy_dictionary.dart';

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GalleryItem(),
      ),
    );
  }
}
