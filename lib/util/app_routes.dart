import 'package:get/get.dart';
import 'package:musicapp/page/home/home_view.dart';
import 'package:musicapp/page/play_track/play_track_view.dart';

import '../page/dashboard/dash_board_view.dart';
import '../page/favorite/favorite_binding.dart';
import '../page/favorite/favorite_view.dart';
import '../page/splash/MPSplashScreen.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = [
    GetPage(
      name: RouterNames.SFLASH,
      page: () => MPSplashScreen(),
    ),
    GetPage(
      name: RouterNames.HOME,
      page: () => const HomePage(),
    ),
    GetPage(
      name: RouterNames.TRACK_PAGE,
      page: () => PlayTrackPage(),
    ),
    GetPage(
      name: RouterNames.FAVORITE,
      page: () => FavoritePage(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: RouterNames.DASH_BOARD,
      page: () => MPDashboardScreen(),
    )
  ];
}

class RouterNames {
  RouterNames._();
  static const SFLASH = '/';
  static const HOME = '/home';
  static const TRACK_PAGE = '/home/track_page';
  static const FAVORITE = '/favorite';
  static const DASH_BOARD = '/dash_board';
}
