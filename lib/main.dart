import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musicapp/app_delegate.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color // status bar color
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppDelegate();
    // return MaterialApp(
    //   home: AudioServiceWidget(child: HomePage()),
    // );
  }
}

// ChangeNotifierProvider(
//         create: (_) => DigitalInkRecognitionState(),
//         child: DigitalInkRecognitionPage(),

