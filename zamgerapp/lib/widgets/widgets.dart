import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamgerapp/ZamgerAPI/secure_storage.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/configuration/themeconfiguration.dart';
import 'package:zamgerapp/models/announcement.dart';
import 'package:zamgerapp/models/examLatest.dart';
import 'package:zamgerapp/models/person.dart';
import 'package:zamgerapp/navigation/login/login_screen.dart';
import 'package:zamgerapp/navigation/messaging/message_screen.dart';
import 'package:http/http.dart' as http;
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track('opacity')
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track('translateX').add(
          Duration(milliseconds: 500), Tween(begin: 120.0, end: 0.0),
          curve: Curves.easeOut)
    ]);
    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation['opacity'],
        child: Transform.translate(
          offset: Offset(animation['translateX'], 0),
          child: child,
        ),
      ),
    );
  }
}

Widget examItem(ExamLatest latestExam) {
  return AspectRatio(
    aspectRatio: 1 / 1.5,
    child: GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: Image.asset('images/exam.jpg').image,
              fit: BoxFit.cover,
            )),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.bottomCenter, stops: [
                .2,
                .9
              ], colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.3),
              ])),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    FontAwesomeIcons.pen,
                    color: Colors.white,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      latestExam.result.toString() +
                          '/' +
                          latestExam.exam.courseActivity.points.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      latestExam.exam.courseUnit.abbrev,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget announcement(BuildContext context, Announcement announcement) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: MaterialButton(
      padding: const EdgeInsets.all(0),
      elevation: 0.5,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: () {},
      onLongPress: () {
        _showAnnouncementDetails(context, announcement);
      },
      child: Row(
        children: <Widget>[
          Ink(
            height: 100,
            width: 100,
            child: Center(
              child: Icon(
                FontAwesomeIcons.bullhorn,
                size: 40,
              ),
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            announcement.sender.email,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          announcement.text == ""
                              ? Text(announcement.subject,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10))
                              : Text(announcement.text,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10))
                        ],
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    ),
  );
}

_showAnnouncementDetails(BuildContext context, Announcement announcement) {
  AlertDialog alert = AlertDialog(
    title: Text('Obavještenje'),
    content: SingleChildScrollView(
      child: announcement.text == ""
          ? Text(announcement.subject)
          : Text(announcement.text),
    ),
    actions: [
      TextButton(
        onPressed: () async {
          Navigator.of(context).pop();
        },
        child: Text('OK'),
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

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
          width: MediaQuery.of(context).size.width -
              66, //sum of all insets is 66px
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
                  backgroundImage: Image.asset('images/user_icon.png').image,
                  backgroundColor: Colors.transparent,
                  radius: 25,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 25,
                    children: [
                      Text(
                        _userName,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          _time,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 12,
                            letterSpacing: -0.6,
                            color: etfBlue,
                          ),
                        ),
                      ),
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
  String accessToken = await Credentials.getAccessToken();
  String refreshToken = await Credentials.getRefreshToken();
  if (accessToken == null || refreshToken == null) {
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
      return LoginPage();
    }
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = etfBlue;
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

Widget message(message, condition, time, context) {
  return Align(
    alignment:
        condition == 'sent' ? Alignment.bottomRight : Alignment.bottomLeft,
    child: Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 4,
        bottom: 4,
      ),
      child: Row(
        mainAxisAlignment: condition == "sent"
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white54,
                  ],
                ),
                borderRadius: BorderRadius.circular(
                  18,
                ),
              ),
              child: Wrap(
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        time,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                      child: Text(
                        message,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget senderDetails(name) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5.0),
    child: Container(
      height: 65,
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset('images/user_icon.png').image,
              ),
              shape: BoxShape.circle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget receiverDetails(name) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5.0),
    child: Container(
      height: 65,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset('images/user_icon.png').image,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
