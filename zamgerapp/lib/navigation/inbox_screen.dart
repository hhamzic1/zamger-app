import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/models/index.dart';

import 'message_screen.dart';

class Inbox extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Inbox> with SingleTickerProviderStateMixin {
  TabController tabController;
  int pageIndex;
  Messages _inbox;
  Messages _outbox;
  Messages _unread;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    fetchInbox();
    fetchOutbox();
    fetchUnread();
  }

  void fetchInbox() async {
    var response = await Provider.of<ZamgerAPIService>(context, listen: false)
        .getRecentRecievedMessages(1000);
    setState(() {
      _inbox = Messages.fromJson(response.body);
    });
  }

  void fetchOutbox() async {
    var response = await Provider.of<ZamgerAPIService>(context, listen: false)
        .getRecentSentMessages(1000);
    setState(() {
      _outbox = Messages.fromJson(response.body);
    });
  }

  void fetchUnread() async {
    var response = await Provider.of<ZamgerAPIService>(context, listen: false)
        .getUnreadMessages();
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

  Widget chatItems(userName, message, time) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Screen2(),
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
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
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
                          userName,
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
                        time,
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
                          message,
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
                      chatItems(
                          _inbox.results[index].sender.login,
                          _inbox.results[index].text,
                          _inbox.results[index].time),
                    ],
                  );
                }),
            onRefresh: () async {
              setState(() {
                fetchInbox();
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
                      chatItems(
                          _outbox.results[index].receiverPerson.login,
                          _outbox.results[index].text,
                          _outbox.results[index].time),
                    ],
                  );
                }),
            onRefresh: () async {
              setState(() {
                fetchOutbox();
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
                      chatItems(
                          _unread.results[index].sender.login,
                          _unread.results[index].text,
                          _unread.results[index].time),
                    ],
                  );
                }),
            onRefresh: () async {
              setState(() {
                fetchUnread();
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
