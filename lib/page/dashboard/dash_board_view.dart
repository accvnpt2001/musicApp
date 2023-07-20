import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicapp/page/favorite/favorite_controller.dart';
import 'package:musicapp/page/home/home_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../util/MPColors.dart';
import '../dicovery/discovery_view.dart';
import '../favorite/favorite_view.dart';

class MPDashboardScreen extends StatefulWidget {
  @override
  MPDashboardScreenState createState() => MPDashboardScreenState();
}

class MPDashboardScreenState extends State<MPDashboardScreen> {
  DateTime? currentBackPressTime;
  int currentIndex = 0;

  final tabs = [
    // MPSplashScreen(),
    const DiscoveryPage(),
    const HomePage(),
    FavoritePage(),
  ];

  @override
  void initState() {
    Get.lazyPut<FavoriteController>(() => FavoriteController());
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: mpAppBackGroundColor,
          body: Stack(
            children: [
              tabs[currentIndex],
              Positioned(
                left: 0,
                right: 0,
                bottom: 4,
                child: BottomNavigationBar(
                  selectedItemColor: mpAppButtonColor,
                  unselectedItemColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: mpBottomBgColor.withOpacity(0.9),
                  currentIndex: currentIndex,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Discover'),
                    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Song'),
                    // BottomNavigationBarItem(icon: Icon(Icons.album), label: 'Albums'),
                    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
                    // BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
                  ],
                  onTap: (index) {
                    currentIndex = index;
                    setState(() {});
                  },
                ).cornerRadiusWithClipRRect(30).paddingOnly(left: 16, right: 16, bottom: 8),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Tap again to exit",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      SystemNavigator.pop();
    }
    return Future.value(false);
  }
}
