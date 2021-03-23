import 'package:flutter/material.dart';

import 'login/pages/loginpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
