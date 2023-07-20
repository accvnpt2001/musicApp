import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'util/app_routes.dart';

class AppDelegate extends StatefulWidget {
  const AppDelegate({Key? key}) : super(key: key);

  @override
  _AppDelegateState createState() => _AppDelegateState();
}

class _AppDelegateState extends State<AppDelegate> with WidgetsBindingObserver {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      WidgetsBinding.instance.addObserver(this);
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resume");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ScreenUtilInit(
        designSize: const Size(320, 568),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => BackGestureWidthTheme(
          backGestureWidth: BackGestureWidth.fraction(1 / 10),
          child: GetMaterialApp(
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
              },
            )),
            initialRoute: RouterNames.SFLASH,
            getPages: AppRoutes.routes,
          ),
        ),
      ),
    );
  }
}
