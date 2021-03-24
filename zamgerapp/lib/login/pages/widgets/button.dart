import 'dart:convert';

import 'package:flutter/material.dart';
import '../login_screen.dart';
import 'package:http/http.dart' as http;

class ButtonLogin extends StatefulWidget {
  @override
  ButtonLoginState createState() => ButtonLoginState();
}

class ButtonLoginState extends State<ButtonLogin> {
  static final usernameController = TextEditingController();
  static final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.yellow[700],
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextButton(
          onPressed: () {
            loginUser(usernameController.text, passwordController.text)
                .then((response) => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      )
                    });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> loginUser(String username, String password) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://sso.etf.unsa.ba/auth/realms/etf.unsa.ba/protocol/openid-connect/token'));
    request.bodyFields = {
      'username': username,
      'password': password,
      'grant_type': 'password',
      'client_id': 'admin-cli'
    };
    request.headers.addAll(headers);

    http.StreamedResponse sResponse = await request.send();
    var response = await http.Response.fromStream(sResponse);

    if (response.statusCode == 200) {
      var resp = jsonDecode(response.body);
      print(resp["access_token"]);
    } else {
      print(response.reasonPhrase);
    }
  }
}
