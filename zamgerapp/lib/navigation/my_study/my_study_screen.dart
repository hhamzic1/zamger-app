import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/configuration/themeconfiguration.dart';
import 'package:zamgerapp/models/enrollment.dart';
import 'package:zamgerapp/models/index.dart';
import 'package:zamgerapp/models/person.dart';
import 'package:zamgerapp/navigation/my_study/subject_details_screen.dart';

class MyStudyPage extends StatefulWidget {
  Person _currentPerson;
  MyStudyPage(Person currentPerson) {
    _currentPerson = currentPerson;
  }
  @override
  _MyStudyPageState createState() => _MyStudyPageState(_currentPerson);
}

class _MyStudyPageState extends State<MyStudyPage> {
  Person _currentPerson;
  Courses _myCourses;
  Courses _filteredCourses;
  Enrollment _myEnrollment;
  String _searchText;
  final TextEditingController _filter = new TextEditingController();

  _MyStudyPageState(Person currentPerson) {
    _currentPerson = currentPerson;
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        _searchText = "";
        _filteredCourses = _myCourses;
      } else {
        _filteredCourses = new Courses();
        _filteredCourses.results = [];
        _searchText = _filter.text.toLowerCase();
        for (int i = 0; i < _myCourses.results.length; i++) {
          if (_myCourses.results[i].courseOffering.courseUnit.name
                  .toLowerCase()
                  .contains(_searchText) ||
              _myCourses.results[i].courseOffering.courseUnit.abbrev
                  .toLowerCase()
                  .contains(_searchText)) {
            _filteredCourses.results.add(_myCourses.results[i]);
          }
        }
        setState(() {});
      }
    });
  }

  void initState() {
    super.initState();
    _fetchMyStudy();
    _fetchMyEnrollment();
  }

  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return _filteredCourses == null || _myEnrollment == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Color(0xfff0f0f0),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 145),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: _filteredCourses.results.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildList(context, index);
                          }),
                    ),
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [lightBlue, etfBlue]),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Moj studij",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 50,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  _myEnrollment.programme.name +
                                      ' - ' +
                                      _myEnrollment.enrollmentType.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 110,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Material(
                              elevation: 5.0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              child: TextField(
                                controller: _filter,
                                cursorColor: Theme.of(context).primaryColor,
                                style: dropdownMenuItem,
                                decoration: InputDecoration(
                                    hintText: "Pretraži predmet",
                                    hintStyle: TextStyle(
                                        color: Colors.black38, fontSize: 16),
                                    prefixIcon: Material(
                                      elevation: 0.0,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      child: Icon(Icons.search),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 13)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Widget buildList(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SubjectDetailsPage(
                _currentPerson, _filteredCourses.results[index])));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(children: [
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 3, color: etfBlue),
                ),
                child: Icon(FontAwesomeIcons.book),
              ),
              _filteredCourses.results[index].grade == null
                  ? SizedBox(
                      height: 5,
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 15, 0),
                      child: Text(
                        _filteredCourses.results[index].grade.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: etfBlue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    )
            ]),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _filteredCourses
                        .results[index].courseOffering.courseUnit.name,
                    style: TextStyle(
                        color: etfBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.graduationCap,
                        color: etfBlue,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                          ' ' +
                              _filteredCourses.results[index].courseOffering
                                  .academicYear.name,
                          style: TextStyle(
                              color: etfBlue, fontSize: 13, letterSpacing: .3))
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  _buildGrade(_filteredCourses.results[index]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGrade(Course crs) {
    if (crs.grade == null) {
      return Row(
        children: <Widget>[
          Icon(
            Icons.close_outlined,
            color: Colors.red,
            size: 22,
          ),
          SizedBox(
            width: 5,
          ),
          Text('Predmet nije položen',
              style:
                  TextStyle(color: etfBlue, fontSize: 13, letterSpacing: .3)),
        ],
      );
    } else {
      return Row(
        children: [
          Icon(
            FontAwesomeIcons.calendar,
            color: etfBlue,
            size: 20,
          ),
          SizedBox(
            width: 5,
          ),
          Text('Datum ocjene: ' + crs.gradeDate,
              style: TextStyle(color: etfBlue, fontSize: 13, letterSpacing: .3))
        ],
      );
    }
  }

  Future<void> _fetchMyStudy() async {
    var response = await ZamgerAPIService.getMyStudy(_currentPerson.id);
    if (response.statusCode == 200) {
      _myCourses = Courses.fromJson(response.data);
      _filteredCourses = Courses.fromJson(response.data);
      setState(() {});
    }
  }

  Future<void> _fetchMyEnrollment() async {
    var response =
        await ZamgerAPIService.getMyEnrollmentInfo(_currentPerson.id);
    if (response.statusCode == 200) {
      setState(() {
        _myEnrollment = Enrollment.fromJson(response.data);
      });
    }
  }
}
