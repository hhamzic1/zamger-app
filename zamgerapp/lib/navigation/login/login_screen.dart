import 'package:flutter/material.dart';
import 'package:zamgerapp/configuration/themeconfiguration.dart';
import 'package:zamgerapp/navigation/drawer.dart';
import 'package:zamgerapp/navigation/home_screen.dart';
import 'package:zamgerapp/navigation/login/widgets/button.dart';
import 'package:zamgerapp/navigation/login/widgets/inputEmail.dart';
import 'package:zamgerapp/navigation/login/widgets/password.dart';
import 'package:zamgerapp/navigation/login/widgets/textLogin.dart';
import 'package:zamgerapp/navigation/login/widgets/verticalText.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [lightBlue, etfBlue]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ]),
                InputEmail(),
                PasswordInput(),
                ButtonLogin(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [DrawerScreen(), HomeScreen()],
      ),
    );
  }
}
