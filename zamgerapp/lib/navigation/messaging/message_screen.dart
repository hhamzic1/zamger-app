import 'package:dio/dio.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/models/index.dart';

class MessageScreen extends StatefulWidget {
  String _message;
  String _time;
  Person _person;
  int _me;
  int _messageId;
  String _type;
  MessageScreen(
      int msgId, String msg, String time, Person prsn, int me, String type) {
    _message = msg;
    _time = time;
    _person = prsn;
    _me = me;
    _type = type;
    _messageId = msgId;
  }
  @override
  _MessageState createState() =>
      _MessageState(_messageId, _message, _time, _person, _me, _type);
}

class _MessageState extends State<MessageScreen> {
  String _message;
  int _messageId;
  String _time;
  Person _person;
  int _me;
  String _type;
  bool _isSendButtonDisabled = false;
  bool _isMessageInputEnabled = true;
  List<Pair<String, Pair<String, Person>>> _conversation = [];

  @override
  void initState() {
    super.initState();
    _conversation.add(new Pair(_message, new Pair(_time, _person)));
    if (_type == 'compose') {
      _fetchMyId();
    }
    if (_type == 'unread') {
      _markMessageAsSeen();
    }
  }

  Future<void> _fetchMyId() async {
    var response = await ZamgerAPIService.currentPerson();
    if (response.statusCode == 200) {
      Person person = Person.fromJson(response.data);
      _me = person.id;
    }
  }

  Future<void> _markMessageAsSeen() async {
    Response response = await ZamgerAPIService.getMessageById(_messageId);
    if (response.statusCode == 200) {
      Message msg = Message.fromJson(response.data);
    }
  }

  final replyController = TextEditingController();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  _MessageState(int messageId, String msg, String time, Person prsn, int me,
      String type) {
    _message = msg;
    _time = time;
    _person = prsn;
    _me = me;
    _messageId = messageId;
    _type = type;
    if (type == 'outbox') {
      _isSendButtonDisabled = true;
      _isMessageInputEnabled = false;
      replyController.text = "Ne možete odgovoriti na ovu poruku . . .";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.amber[900],
                    Colors.red,
                  ],
                  begin: Alignment.center,
                  end: Alignment.centerRight,
                  stops: [0.5, 03]),
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(_person.login),
                    centerTitle: true,
                    elevation: 0,
                    leading: GestureDetector(
                      child: Icon(Icons.arrow_back_ios),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SwipeDetector(
                    onSwipeLeft: () {
                      print("left");
                    },
                    onSwipeRight: () {
                      print("Right");
                      Navigator.pop(context);
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: _buildConversation()),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 35,
            child: Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                height: 50,
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                        enabled: _isMessageInputEnabled,
                        controller: replyController,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            hintText: 'Odgovori . . .',
                            contentPadding: EdgeInsets.all(15.0),
                            border: InputBorder.none),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.amber[900],
                            shape: BoxShape.circle,
                          ),
                          child: TextButton(
                            child: Icon(Icons.send, color: Colors.white),
                            onPressed: _isSendButtonDisabled
                                ? null
                                : () async {
                                    await _sendMessage();
                                    setState(() {});
                                  },
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversation() {
    return _conversation.length != 0
        ? RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: _conversation.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_type != 'outbox' && _type != 'compose') {
                    if (index < 1) {
                      return Column(
                        children: [
                          senderDetails(
                              _conversation[index].right.right.name +
                                  " " +
                                  _conversation[index].right.right.surname,
                              'https://library.kissclipart.com/20180906/wkw/kissclipart-user-icon-png-clipart-user-profile-computer-icons-94f08bfdb73bc68b.jpg'),
                          message(_conversation[index].left, 'recieved',
                              _conversation[index].right.left)
                        ],
                      );
                    } else if (index == 1) {
                      return Column(
                        children: [
                          receiverDetails('Ja',
                              'https://library.kissclipart.com/20180906/wkw/kissclipart-user-icon-png-clipart-user-profile-computer-icons-94f08bfdb73bc68b.jpg'),
                          message(_conversation[index].left, 'sent',
                              _conversation[index].right.left)
                        ],
                      );
                    } else {
                      return message(_conversation[index].left, 'sent',
                          _conversation[index].right.left);
                    }
                  } else if (_type == 'compose') {
                    if (index < 1) {
                      return receiverDetails('Ja',
                          'https://library.kissclipart.com/20180906/wkw/kissclipart-user-icon-png-clipart-user-profile-computer-icons-94f08bfdb73bc68b.jpg');
                    } else {
                      return message(_conversation[index].left, 'sent',
                          _conversation[index].right.left);
                    }
                  } else {
                    return Column(
                      children: [
                        receiverDetails('Ja',
                            'https://library.kissclipart.com/20180906/wkw/kissclipart-user-icon-png-clipart-user-profile-computer-icons-94f08bfdb73bc68b.jpg'),
                        message(_conversation[index].left, 'sent',
                            _conversation[index].right.left)
                      ],
                    );
                  }
                }),
            onRefresh: () async {
              setState(() {});
            },
          )
        : Center(child: CircularProgressIndicator());
  }

  Future<void> _sendMessage() async {
    Person sender = new Person();
    sender.id = _me;
    Message msg = new Message();
    msg.id = 0;
    msg.type = 2;
    msg.scope = 7;
    msg.receiver = _person.id;
    msg.sender = sender;
    msg.time = "";
    msg.ref = 0;
    msg.subject = "zamger-app message";
    msg.text = replyController.text;
    msg.unread = false;

    var response = await ZamgerAPIService.sendMessage(msg);
    if (response.statusCode == 201) {
      Message responseMessage = Message.fromJson(response.data);
      _conversation.add(new Pair(responseMessage.text,
          new Pair(formatter.format(DateTime.now()), null)));
      replyController.text = '';
    } else {
      _conversation.add(new Pair(
          replyController.text + " - failed to send message",
          new Pair(formatter.format(DateTime.now()), null)));
      replyController.text = '';
    }
  }

  Widget senderDetails(name, imageUrl) {
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
                  image: NetworkImage(imageUrl),
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

  Widget receiverDetails(name, imageUrl) {
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
                    image: NetworkImage(imageUrl),
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

  Widget message(message, condition, time) {
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
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: condition == "sent"
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
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
              child: Column(
                  crossAxisAlignment: condition == 'sent'
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
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
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                          child: Text(
                            message,
                            maxLines: null,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
