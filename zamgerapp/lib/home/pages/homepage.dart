import 'package:flutter/material.dart';
import 'package:zamgerapp/navigation/homescreen.dart';
import 'package:zamgerapp/navigation/drawer.dart';

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
