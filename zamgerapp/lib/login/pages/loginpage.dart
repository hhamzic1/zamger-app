import 'package:flutter/material.dart';
import 'package:zamgerapp/login/pages/widgets/button.dart';
import 'package:zamgerapp/login/pages/widgets/inputEmail.dart';
import 'package:zamgerapp/login/pages/widgets/password.dart';
import 'package:zamgerapp/login/pages/widgets/textLogin.dart';
import 'package:zamgerapp/login/pages/widgets/verticalText.dart';

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
              colors: [Colors.yellow[300], Colors.amber[900]]),
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
