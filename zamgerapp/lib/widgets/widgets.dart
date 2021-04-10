import 'package:flutter/material.dart';
import 'package:zamgerapp/ZamgerAPI/secure_storage.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/login/pages/login_screen.dart';
import 'package:zamgerapp/models/person.dart';
import 'package:zamgerapp/navigation/messaging/message_screen.dart';
import 'package:http/http.dart' as http;

class ChatItems extends StatelessWidget {
  String _userName;
  String _message;
  String _time;
  Person _person;
  int _me;
  String _type;
  int _messageId;

  ChatItems(int messageId, String userName, String message, String time,
      Person person, int me, String type) {
    _userName = userName;
    _message = message;
    _time = time;
    _person = person;
    _me = me;
    _type = type;
    _messageId = messageId;
  }
  @override
  build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                MessageScreen(_messageId, _message, _time, _person, _me, _type),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18, left: 2, right: 2),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300].withOpacity(0.7),
                  blurRadius: 2,
                  spreadRadius: 2)
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              50,
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://library.kissclipart.com/20180906/wkw/kissclipart-user-icon-png-clipart-user-profile-computer-icons-94f08bfdb73bc68b.jpg'),
                  backgroundColor: Colors.transparent,
                  radius: 25,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 120,
                        child: Text(
                          _userName,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                      Text(
                        _time,
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: -0.6,
                          color: Colors.amber[800],
                        ),
                      ),
                      SizedBox(width: 5)
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          _message,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[500].withOpacity(0.7),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<Widget> checkAPPCredentials() async {
  await Credentials.deleteTokens();
  String accessToken = await Credentials.getAccessToken();
  String refreshToken = await Credentials.getRefreshToken();
  if (accessToken == null || refreshToken == null) {
    print("Ovdje je ušlo");
    return LoginPage();
  } else {
    var headers = {'Authorization': 'Bearer ' + accessToken};
    var request = http.Request(
        'GET', Uri.parse('https://zamger.etf.unsa.ba/api_v6/person'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      ZamgerAPIService();
      return HomePage();
    } else {
      print("dole je ušlo");
      return LoginPage();
    }
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.amber[900];
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.55);
    path.quadraticBezierTo(
        size.width / 2, 1.5 * size.height, size.width, size.height * 0.5);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
