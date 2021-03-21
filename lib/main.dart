import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'app/views/splash_screen/splash_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      allowFontScaling: false,
      builder: () => GetMaterialApp(
        title: 'Techno Construction Workers',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: main_color,
        ),
        home: SplashPage(),
      ),
    );
  }
}
