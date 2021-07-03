import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zamgerapp/navigation/login/login_screen.dart';
import 'package:zamgerapp/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
        ),
      ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var initialzationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings =
      InitializationSettings(android: initialzationSettingsAndroid);

  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  runApp(ZamgerApp());
}

final GlobalKey<NavigatorState> navigator = new GlobalKey<NavigatorState>();

class ZamgerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator,
      routes: {"/login": (context) => LoginPage()},
      title: 'Zamger App',
      home: AnimatedSplashScreen.withScreenFunction(
          splash: Image.asset('images/etf.png'),
          splashTransition: SplashTransition.fadeTransition,
          screenFunction: () async => checkAPPCredentials()),
      debugShowCheckedModeBanner: false,
    );
  }
}
