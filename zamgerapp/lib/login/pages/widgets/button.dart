import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zamgerapp/ZamgerAPI/secure_storage.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
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
              blurRadius: 10.0,
              spreadRadius: 1.0,
              offset: Offset(
                5.0,
                5.0,
              ),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextButton(
          onPressed: () async =>
              loginUser(usernameController.text, passwordController.text),
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
      var responseBody = jsonDecode(response.body);
      await Credentials.saveTokens(
          responseBody['access_token'], responseBody['refresh_token']);
      ZamgerAPIService();
      usernameController.text = '';
      passwordController.text = '';
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      usernameController.text = '';
      passwordController.text = '';
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Greška"),
      content: Text("Pogrešni pristupni podaci, molimo unesite ih ponovo!"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
