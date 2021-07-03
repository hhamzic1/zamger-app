import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamgerapp/FCM/helpers.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/models/announcements.dart';
import 'package:zamgerapp/models/examLatest.dart';
import 'package:zamgerapp/models/firebaseToken.dart';
import 'package:zamgerapp/models/person.dart';
import 'package:zamgerapp/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  Person _currentPerson;
  List<ExamLatest> _recentExamResults;
  Announcements _recentAnnouncements;

  @override
  void initState() {
    super.initState();
    _fetchHomepageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDrawerOpen
                      ? IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              xOffset = 230;
                              yOffset = 150;
                              scaleFactor = 0.6;
                              isDrawerOpen = true;
                            });
                          }),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Početna',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: Image.asset('images/user_icon.png').image,
                    backgroundColor: Colors.transparent,
                    radius: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Aktuelno (Ispiti)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(height: 250, child: _buildRecentExamResults()),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Aktuelno (Obavještenja)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: _recentAnnouncements == null ||
                      _recentAnnouncements.results.length == 0
                  ? [
                      Center(
                        child: Text(
                          'Nema aktuelnih obavještenja',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                      )
                    ]
                  : _recentAnnouncements.results.map((element) {
                      return announcement(context, element);
                    }).toList(),
            ),
            SizedBox(
              height: 300,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRecentExamResults() {
    if (_recentExamResults != null && _recentExamResults.length == 0) {
      return Center(
        child: Text('Nema aktuelnih ispitnih rezultata',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
      );
    }
    return _recentExamResults == null
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _recentExamResults.length,
                itemBuilder: (BuildContext context, int index) {
                  return examItem(_recentExamResults[index]);
                }),
          );
  }

  _fetchHomepageInfo() async {
    var response = await ZamgerAPIService.currentPerson();
    if (response.statusCode == 200) {
      _currentPerson = Person.fromJson(response.data);
      await _updateFirebaseToken();
      await _fetchRecentExamResults(_currentPerson.id);
      await _fetchRecentAnnouncements();
      setState(() {});
    }
  }

  Future<void> _fetchRecentExamResults(studentId) async {
    var response = await ZamgerAPIService.getLatestExamResults(studentId);
    if (response.statusCode == 200) {
      _recentExamResults = (response.data['results'] as List)
          ?.map((e) =>
              e == null ? null : ExamLatest.fromJson(e as Map<String, dynamic>))
          ?.toList();
    }
  }

  Future<void> _fetchRecentAnnouncements() async {
    var response = await ZamgerAPIService.getInboxAnnouncements();
    if (response.statusCode == 200) {
      _recentAnnouncements = Announcements.fromJson(response.data);
    }
  }

  Future<void> _updateFirebaseToken() async {
    var person = new Person();
    person.id = _currentPerson.id;
    print(person.toJson());
    FirebaseToken token = new FirebaseToken();
    token.person = person;
    token.deviceToken = await FCMHelpers.getToken();
    print(token.toJson());
    var response = await ZamgerAPIService.updateFirebaseDeviceToken(token);
    if (response.statusCode == 201) {
      print("fcm token se syncao sa zamgerom!");
    } else {
      print("fcm token se nije syncao sa zamgerom!");
    }
  }
}
