import 'package:flutter/material.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/configuration/themeconfiguration.dart';
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
    var response = await ZamgerAPIService.getRecentRecievedMessages(50);
    setState(() {
      _inbox = Messages.fromJson(response.data);
    });
  }

  void _fetchOutbox() async {
    var response = await ZamgerAPIService.getRecentSentMessages(50);
    setState(() {
      _outbox = Messages.fromJson(response.data);
    });
  }

  void _fetchUnread() async {
    var response = await ZamgerAPIService.getUnreadMessages();
    setState(() {
      _unread = Messages.fromJson(response.data);
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
                      backgroundColor: etfBlue,
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
                              "Nepročitano",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: TabBarView(controller: tabController, children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 23.0, right: 23, top: 30),
                      child: _buildList(
                          'inbox', _inbox, _fetchInbox, 'Inbox je prazan'),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 23.0, right: 23, top: 30),
                      child: _buildList(
                          'outbox', _outbox, _fetchOutbox, 'Outbox je prazan'),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 23.0, right: 23, top: 30),
                      child: _buildList('unread', _unread, _fetchUnread,
                          'Nemate nepročitanih poruka'),
                    ),
                  ),
                ]))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(String type, list, onStateFun, onEmptyMessage) {
    Widget tempWidget = _checkList(list, onEmptyMessage, onStateFun);
    if (tempWidget != null) {
      return tempWidget;
    }
    return list != null
        ? RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: list.results.length,
                itemBuilder: (BuildContext context, int index) {
                  if (type == 'unread') {
                    return Row(
                      children: <Widget>[
                        SizedBox(height: 10),
                        ChatItems(
                            list.results[index].id,
                            list.results[index].sender.login,
                            list.results[index].text,
                            list.results[index].time,
                            list.results[index].sender,
                            list.results[index].receiver,
                            "unread"),
                      ],
                    );
                  } else if (type == 'inbox') {
                    return Row(
                      children: <Widget>[
                        SizedBox(height: 10),
                        ChatItems(
                            list.results[index].id,
                            list.results[index].sender.login,
                            list.results[index].text,
                            list.results[index].time,
                            list.results[index].sender,
                            list.results[index].receiver,
                            "inbox"),
                      ],
                    );
                  } else {
                    return Row(
                      children: <Widget>[
                        SizedBox(height: 10),
                        ChatItems(
                            list.results[index].id,
                            list.results[index].receiverPerson.login,
                            list.results[index].text,
                            list.results[index].time,
                            list.results[index].receiverPerson,
                            list.results[index].sender.id,
                            "outbox"),
                      ],
                    );
                  }
                }),
            onRefresh: () async {
              setState(() {
                onStateFun();
              });
            },
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _checkList(list, message, Function onStateFun) {
    if (list != null && list.results.length == 0) {
      return RefreshIndicator(
        child: Center(
            child: Text(
          message,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        )),
        onRefresh: () async {
          setState(() {
            onStateFun();
          });
        },
      );
    }
    return null;
  }
}
