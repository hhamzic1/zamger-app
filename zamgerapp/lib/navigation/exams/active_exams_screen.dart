import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/configuration/themeconfiguration.dart';
import 'package:zamgerapp/models/event.dart';
import 'package:zamgerapp/models/index.dart';
import 'package:zamgerapp/widgets/widgets.dart';

class ActiveExamsPage extends StatefulWidget {
  Person _currentPerson;
  ActiveExamsPage(Person currentPerson) {
    _currentPerson = currentPerson;
  }
  @override
  _ActiveExamsPageState createState() => _ActiveExamsPageState(_currentPerson);
}

class _ActiveExamsPageState extends State<ActiveExamsPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  Person _currentPerson;
  List<Event> _activeExams;
  List<Event> _registeredExams;
  int pageIndex;

  _ActiveExamsPageState(Person currentPerson) {
    _currentPerson = currentPerson;
  }
  @override
  void initState() {
    super.initState();
    _fetchMyExams();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
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
                      title: Text("Ispiti"),
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
                              "Aktivni",
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Prijavljeni",
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
                    child: _buildExams(true),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 23.0, right: 23, top: 30),
                    child: _buildExams(false),
                  ),
                ]))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExams(bool active) {
    List<Event> _tempList;
    active == true ? _tempList = _activeExams : _tempList = _registeredExams;

    if (_tempList != null && _tempList.length == 0) {
      return RefreshIndicator(
        child: Center(
          child: active == true
              ? Text(
                  'Nemate aktivnih ispita',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )
              : Text(
                  'Nemate prijavljenih ispita',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
        ),
        onRefresh: () async {
          setState(() {
            _fetchMyExams();
          });
        },
      );
    }

    return _tempList != null
        ? RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                itemCount: _tempList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 8.0,
                    margin: new EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [lightBlue, etfBlue]),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                      width: 1.0, color: Colors.white24))),
                          child: Icon(
                            FontAwesomeIcons.pen,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          _tempList[index].courseUnit.name +
                              ' (' +
                              _tempList[index].courseUnit.abbrev +
                              ')',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        subtitle: Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              "Datum održavanja:",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              _tempList[index].dateTime,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Rok prijave:",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              _tempList[index].deadline,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("Prijavljenih:",
                                style: TextStyle(color: Colors.white)),
                            Text(
                                _tempList[index].registered.toString() +
                                    '/' +
                                    _tempList[index].maxStudents.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        trailing: active == true
                            ? TextButton(
                                child: Icon(FontAwesomeIcons.plusCircle,
                                    color: Colors.white, size: 30.0),
                                onPressed: () async {
                                  await _registerForExam(_tempList[index]);
                                },
                              )
                            : TextButton(
                                child: Icon(FontAwesomeIcons.timesCircle,
                                    color: Colors.white, size: 30.0),
                                onPressed: () async {
                                  await _unregisterFromExam(_tempList[index]);
                                },
                              ),
                      ),
                    ),
                  );
                }),
            onRefresh: () async {
              setState(() {
                _fetchMyExams();
              });
            },
          )
        : Center(child: CircularProgressIndicator());
  }

  Future<void> _fetchMyExams() async {
    var response = await ZamgerAPIService.getUpcomingEvents(_currentPerson.id);
    if (response.statusCode == 200) {
      var response2 =
          await ZamgerAPIService.getRegisteredEvents(_currentPerson.id);
      if (response2.statusCode == 200) {
        _activeExams = (response.data['results'] as List)
            ?.map((e) =>
                e == null ? null : Event.fromJson(e as Map<String, dynamic>))
            ?.toList();
        _registeredExams = (response2.data['results'] as List)
            ?.map((e) =>
                e == null ? null : Event.fromJson(e as Map<String, dynamic>))
            ?.toList();

        List<Event> tempList = [];
        for (Event event in _activeExams) {
          if (_amIRegisteredForExam(event)) {
            tempList.add(event);
          }
        }

        for (Event event in tempList) {
          _activeExams.remove(event);
        }

        _registeredExams = tempList;

        setState(() {});
      } else {
        _registeredExams = [];
      }
    } else {
      _activeExams = [];
    }
  }

  bool _amIRegisteredForExam(Event event) {
    if (_registeredExams != null) {
      for (Event e in _registeredExams) {
        if (e.id == event.id) return true;
      }
      return false;
    }
    return false;
  }

  Future<void> _registerForExam(Event event) async {
    var response =
        await ZamgerAPIService.registerForEvent(event.id, _currentPerson.id);
    if (response.statusCode == 201) {
      await _fetchMyExams();
      setState(() {});
    } // nije se prijavilo na ispit
  }

  Future<void> _unregisterFromExam(Event event) async {
    var response =
        await ZamgerAPIService.unregisterForEvent(event.id, _currentPerson.id);
    if (response.statusCode == 204) {
      await _fetchMyExams();
      setState(() {});
    } // nije se odjavilo sa ispita
  }
}
