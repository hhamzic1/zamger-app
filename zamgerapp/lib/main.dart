import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:zamgerapp/navigation/login/login_screen.dart';
import 'package:zamgerapp/widgets/widgets.dart';

void main() => runApp(ZamgerApp());

final GlobalKey<NavigatorState> navigator = new GlobalKey<NavigatorState>();

class ZamgerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator,
      routes: {"/login": (context) => LoginPage()},
      title: 'Zamger App',
      home: AnimatedSplashScreen.withScreenFunction(
          splash: Image.asset('images/etf.png'),
          splashTransition: SplashTransition.fadeTransition,
          screenFunction: () async => checkAPPCredentials()),
      debugShowCheckedModeBanner: false,
    );
  }
}
