import 'package:flutter/material.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/models/index.dart';
import 'package:zamgerapp/navigation/messaging/compose_message_screen.dart';
import 'package:zamgerapp/widgets/widgets.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> with SingleTickerProviderStateMixin {
  TabController tabController;
  int pageIndex;
  Messages _inbox;
  Messages _outbox;
  Messages _unread;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _fetchInbox();
    _fetchOutbox();
    _fetchUnread();
  }

  void _fetchInbox() async {
    var response =
        await ZamgerAPIService.service.getRecentRecievedMessages(1000);
    setState(() {
      _inbox = Messages.fromJson(response.body);
    });
  }

  void _fetchOutbox() async {
    var response = await ZamgerAPIService.service.getRecentSentMessages(1000);
    setState(() {
      _outbox = Messages.fromJson(response.body);
    });
  }

  void _fetchUnread() async {
    var response = await ZamgerAPIService.service.getUnreadMessages();
    setState(() {
      _unread = Messages.fromJson(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomPaint(
              painter: CurvePainter(),
              child: Container(
                height: 300.0,
              ),
            ),
            Column(
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: PreferredSize(
                    preferredSize: Size.fromHeight(100),
                    child: AppBar(
                      backgroundColor: Colors.amber[900],
                      title: Text("Inbox"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ComposeMessagePage(),
                                  ));
                            },
                            child: Icon(Icons.add_sharp, color: Colors.white))
                      ],
                      centerTitle: true,
                      elevation: 0,
                      leading: TextButton(
                        child: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      bottom: TabBar(
                        controller: tabController,
                        unselectedLabelColor: Colors.white.withOpacity(0.4),
                        onTap: (int index) {
                          pageIndex = index;
                        },
                        indicatorColor: Colors.transparent,
                        tabs: [
                          Tab(
                            child: Text(
                              "Inbox",
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Outbox",
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Unread",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: TabBarView(controller: tabController, children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 23.0, right: 23, top: 30),
                    child: _buildInbox(),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 23.0, right: 23, top: 30),
                    child: _buildOutbox(),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 23.0, right: 23, top: 30),
                    child: _buildUnread(),
                  ),
                ]))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInbox() {
    return _inbox != null
        ? RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: _inbox.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: <Widget>[
                      SizedBox(height: 10),
                      ChatItems(
                          _inbox.results[index].id,
                          _inbox.results[index].sender.login,
                          _inbox.results[index].text,
                          _inbox.results[index].time,
                          _inbox.results[index].sender,
                          _inbox.results[index].receiver,
                          "inbox")
                    ],
                  );
                }),
            onRefresh: () async {
              setState(() {
                _fetchInbox();
              });
            },
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _buildOutbox() {
    return _outbox != null
        ? RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: _outbox.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: <Widget>[
                      SizedBox(height: 10),
                      ChatItems(
                          _outbox.results[index].id,
                          _outbox.results[index].receiverPerson.login,
                          _outbox.results[index].text,
                          _outbox.results[index].time,
                          _outbox.results[index].receiverPerson,
                          _outbox.results[index].sender.id,
                          "outbox"),
                    ],
                  );
                }),
            onRefresh: () async {
              setState(() {
                _fetchOutbox();
              });
            },
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _buildUnread() {
    return _unread != null
        ? RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: _unread.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: <Widget>[
                      SizedBox(height: 10),
                      ChatItems(
                          _unread.results[index].id,
                          _unread.results[index].sender.login,
                          _unread.results[index].text,
                          _unread.results[index].time,
                          _unread.results[index].sender,
                          _unread.results[index].receiver,
                          "unread"),
                    ],
                  );
                }),
            onRefresh: () async {
              setState(() {
                _fetchUnread();
              });
            },
          )
        : Center(child: CircularProgressIndicator());
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
