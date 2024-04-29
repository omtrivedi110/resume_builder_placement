import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder_placement/utils/route_utils.dart';
import 'package:resume_builder_placement/views/screens/add_resume.dart';
import 'package:resume_builder_placement/views/screens/home.dart';
import 'package:resume_builder_placement/views/screens/resume_item_detail.dart';
import 'package:resume_builder_placement/views/screens/resume_screen.dart';
import 'package:resume_builder_placement/views/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: MyRoutes.splash, page: () => SplashScreen()),
        GetPage(name: MyRoutes.home, page: () => HomePage()),
        GetPage(name: MyRoutes.addResume, page: () => AddResume()),
        GetPage(name: MyRoutes.itemDetail, page: () => ResumeItemDetail()),
        GetPage(name: MyRoutes.resume_screen, page: () => ResumeScreen()),
      ],
    );
  }
}
