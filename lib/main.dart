import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:finance_app/const.dart';
import 'package:finance_app/views/homePage.dart';
import 'package:finance_app/widgets/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/add_date.dart';
import 'views/StatisticsPage.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AdddataAdapter());
  await Hive.openBox<Add_data>('data');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Finance Bomb',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
            splashIconSize: 500,
            splash: 'assets/images/splash-image.png',
            nextScreen: BottomBarWidget(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: kPrimaryColor));
  }
}
