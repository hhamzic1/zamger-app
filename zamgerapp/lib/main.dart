import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:zamgerapp/ZamgerAPI/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'login/pages/login_screen.dart';

void main() => runApp(ZamgerApp());

class ZamgerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zamger App',
      home: AnimatedSplashScreen.withScreenFunction(
          splash: Image.asset('images/etf.png'),
          splashTransition: SplashTransition.fadeTransition,
          screenFunction: () async {
            await Credentials.deleteTokens();
            String accessToken = await Credentials.getAccessToken();
            String refreshToken = await Credentials.getRefreshToken();
            if (accessToken == null || refreshToken == null) {
              print("Ovdje je ušlo");
              return LoginPage();
            } else {
              var headers = {'Authorization': 'Bearer ' + accessToken};
              var request = http.Request(
                  'GET', Uri.parse('https://zamger.etf.unsa.ba/api_v6/person'));
              request.headers.addAll(headers);
              http.StreamedResponse response = await request.send();

              if (response.statusCode == 200) {
                return HomePage();
              } else {
                print("dole je ušlo");
                return LoginPage();
              }
            }
          }),
      debugShowCheckedModeBanner: false,
    );
  }
}
