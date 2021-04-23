import 'package:dio/dio.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/configuration/themeconfiguration.dart';
import 'package:zamgerapp/models/index.dart';
import 'package:zamgerapp/widgets/widgets.dart';

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
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [lightBlue, etfBlue]),
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
                            color: etfBlue,
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
                          senderDetails(_conversation[index].right.right.name +
                              " " +
                              _conversation[index].right.right.surname),
                          message(_conversation[index].left, 'recieved',
                              _conversation[index].right.left, context)
                        ],
                      );
                    } else if (index == 1) {
                      return Column(
                        children: [
                          receiverDetails('Ja'),
                          message(_conversation[index].left, 'sent',
                              _conversation[index].right.left, context)
                        ],
                      );
                    } else if (index == _conversation.length - 1) {
                      return Column(children: [
                        message(_conversation[index].left, 'sent',
                            _conversation[index].right.left, context),
                        SizedBox(
                          height: 130,
                        )
                      ]);
                    } else {
                      return message(_conversation[index].left, 'sent',
                          _conversation[index].right.left, context);
                    }
                  } else if (_type == 'compose') {
                    if (index < 1) {
                      return receiverDetails('Ja');
                    } else if (index == _conversation.length - 1) {
                      return Column(children: [
                        message(_conversation[index].left, 'sent',
                            _conversation[index].right.left, context),
                        SizedBox(
                          height: 130,
                        )
                      ]);
                    } else {
                      return message(_conversation[index].left, 'sent',
                          _conversation[index].right.left, context);
                    }
                  } else {
                    return Column(
                      children: [
                        receiverDetails('Ja'),
                        message(_conversation[index].left, 'sent',
                            _conversation[index].right.left, context)
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
}
