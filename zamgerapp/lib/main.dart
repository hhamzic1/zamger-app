import 'package:flutter/material.dart';

import 'login/pages/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zamger App',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
