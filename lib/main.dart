import 'package:flutter/material.dart';
import 'package:movie_app/components/login.dart';
import 'theme/color_schemes.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String? token = '';
  // @override
  // void initState() {
  //   super.initState();
  //   checkPreference();
  // }

  // void checkPreference() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token = prefs.getString('action')!;
  //   debugPrint('>>>>>>>>>>>>>>$token');
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie',
      theme: CustomTheme.darkTheme,
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: './assets/moviedb.png',
        // ignore: unnecessary_null_comparison
        nextScreen: LoginPage(),
        splashTransition: SplashTransition.slideTransition,
        backgroundColor: const Color(0xFF191C1D),
      ),
    );
  }
}
