import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';

import 'login/pages/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => ZamgerAPIService.create(),
        dispose: (_, ZamgerAPIService service) => service.client.dispose(),
        child: MaterialApp(
          title: 'Zamger App',
          home: LoginPage(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
