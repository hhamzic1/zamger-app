import 'package:flutter/material.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/configuration/themeconfiguration.dart';
import 'package:zamgerapp/models/homeworksInfo.dart';
import 'package:zamgerapp/models/index.dart';
import 'package:zamgerapp/navigation/homeworks/homework_info_screen.dart';
import 'package:zamgerapp/widgets/widgets.dart';

class HomeworksPage extends StatefulWidget {
  Person _currentPerson;
  HomeworksPage(Person currentPerson) {
    _currentPerson = currentPerson;
  }

  @override
  _HomeworksState createState() => _HomeworksState(_currentPerson);
}

class _HomeworksState extends State<HomeworksPage> {
  HomeworksInfo _homeworks;
  Person _currentPerson;

  _HomeworksState(Object currentPerson) {
    _currentPerson = currentPerson;
  }

  @override
  void initState() {
    super.initState();
    _fetchActiveHomeworks();
  }

  @override
  Widget build(BuildContext context) {
    return _homeworks != null
        ? Scaffold(
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
                            title: Text("Aktivne zadaće"),
                            centerTitle: true,
                            elevation: 0,
                            leading: TextButton(
                              child: Icon(Icons.arrow_back_ios,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: _buildActiveHomeworks()),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  Future<void> _fetchActiveHomeworks() async {
    var response =
        await ZamgerAPIService.getUpcomingHomeworks(_currentPerson.id);
    if (response.statusCode == 200) {
      setState(() {
        _homeworks = HomeworksInfo.fromJson(response.data);
      });
    }
  }

  Widget _buildActiveHomeworks() {
    return _homeworks != null &&
            _homeworks.results != null &&
            _homeworks.results.length != 0
        ? RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                itemCount: _homeworks.results.length,
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
                          child: _homeworks.results[index].active == true
                              ? Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.hourglass_bottom_rounded,
                                  color: Colors.red,
                                  size: 30,
                                ),
                        ),
                        title: Text(
                          _homeworks.results[index].courseUnit.abbrev,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                direction: Axis.vertical,
                                children: <Widget>[
                                  Text(
                                    "Naziv: " + _homeworks.results[index].name,
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                      "Rok: " +
                                          _homeworks.results[index].deadline,
                                      style: TextStyle(color: Colors.white))
                                ],
                              )
                            ]),
                        trailing: TextButton(
                          child: Icon(Icons.arrow_forward_ios,
                              color: Colors.white, size: 30.0),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeworkInfoPage(
                                    _homeworks.results[index].id,
                                    _homeworks.results[index].courseUnit.id,
                                    _currentPerson)));
                          },
                        ),
                      ),
                    ),
                  );
                }),
            onRefresh: () async {
              setState(() {
                _fetchActiveHomeworks();
              });
            },
          )
        : Center(
            child: Text(
              'Nemate aktivnih zadaća',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          );
  }
}
