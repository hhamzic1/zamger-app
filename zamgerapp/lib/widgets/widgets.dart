import 'package:flutter/material.dart';
import 'package:zamgerapp/models/person.dart';
import 'package:zamgerapp/navigation/messaging/message_screen.dart';

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
