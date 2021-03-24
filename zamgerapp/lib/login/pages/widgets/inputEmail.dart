import 'package:flutter/material.dart';
import 'package:zamgerapp/login/pages/widgets/button.dart';

class InputEmail extends StatefulWidget {
  @override
  _InputEmailState createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: ButtonLoginState.usernameController,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Korisničko ime',
            labelStyle:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
