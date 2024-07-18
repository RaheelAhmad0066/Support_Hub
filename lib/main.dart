import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supporthub/appassets/color/colors.dart';
import 'package:supporthub/appassets/textstyle/textstyles.dart';
import 'package:supporthub/firebase_option.dart';
import 'package:supporthub/view/Screens/Ground/GroundMainController/groundmaincontroller.dart';
import 'package:supporthub/view/Screens/splash/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(GroundMainController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(
            backgroundColor: CustomColors.primary,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: AppTextStyles.medium.copyWith(fontSize: 18)),
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: CustomColors.primary),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
