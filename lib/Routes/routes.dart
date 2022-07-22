import 'package:bloc_pattern/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => AnimatedSplashScreen(
                  splash: "assets/lock.png",
                  splashIconSize: 100,
                  duration: 2000,
                  nextScreen: LoginPage(),
                  splashTransition: SplashTransition.rotationTransition,
                  pageTransitionType: PageTransitionType.fade,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
