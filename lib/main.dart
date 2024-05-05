
import 'package:bloc/bloc.dart';
import 'package:chats_app/shared/bloc_observer.dart';
import 'package:chats_app/shared/cubit/cubit.dart';
import 'package:chats_app/shared/cubit/states.dart';
import 'package:chats_app/shared/network/local/cache_helper.dart';
import 'package:chats_app/shared/network/remote/dio_helpeer.dart';
import 'package:chats_app/shared/styles/colors/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'login.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'modules/shop_app/shop_layout.dart';
import 'modules/shop_app/shop_login/shop_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = (await CacheHelper.getData(key: 'isDark')) ?? false;


  Widget widget;
  bool onBoarding=(await CacheHelper.getData(key: 'onBoarding')) ?? false;
  String? token= await CacheHelper.getData(key: 'token');
  print(token);

  if(onBoarding!=null)
  {
    if(token!=null) widget=ShopLayout();
    else widget=ShopLoginScreen();
  }
  else{
    widget=OnBoardingScreen();
  }

    runApp(MyApp(
      isDark:isDark,
      startWidget: widget,
    ));
  }


class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget  startWidget;

  MyApp({required this.isDark,required this.startWidget});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
            create: (BuildContext context) =>
            AppCubit()..changeAppMode(fromShared: isDark)),
        BlocProvider(
          create: (BuildContext context) =>ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData() ,
        ),

      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:lightTheme,
            darkTheme: darkTheme,
            themeMode:
            AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home:LoginScreen(),
          );
        },
      ),
    );
  }
}
