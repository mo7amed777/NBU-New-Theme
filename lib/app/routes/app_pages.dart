import 'package:get/get.dart';
import 'package:eservices/app/pages/views/login_view.dart';
import 'package:eservices/app/pages/views/profile_screen.dart';
import 'package:eservices/app/pages/views/splash.dart';

import '../pages/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static const LOGIN = Routes.LOGIN;
  static const HOME = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => Splash(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
    ),
  ];
}
