import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/configuration/themeconfiguration.dart';
import 'package:zamgerapp/models/ZClass.dart';
import 'package:zamgerapp/models/detail.dart';
import 'package:zamgerapp/models/index.dart';
import 'package:zamgerapp/models/score.dart';
import 'package:zamgerapp/navigation/homeworks/homework_info_screen.dart';

TextStyle priceTextStyle =
    TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold);

class SubjectDetailsPage extends StatefulWidget {
  Person _currentPerson;
  Course _currentCourse;
  SubjectDetailsPage(Person person, Course crs) {
    _currentPerson = person;
    _currentCourse = crs;
  }
  @override
  State<StatefulWidget> createState() =>
      _SubjectDetailsStatePage(_currentPerson, _currentCourse);
}

class _SubjectDetailsStatePage extends State<SubjectDetailsPage> {
  Person _currentPerson;
  Course _currentCourse;
  Course _courseDetails;
  Score _attendanceActivity;
  Score _homeworkActivity;
  List<Score> _examActivity = [];

  _SubjectDetailsStatePage(Person person, Course course) {
    _currentPerson = person;
    _currentCourse = course;
  }

  @override
  void initState() {
    super.initState();
    _fetchCourseDetails();
  }

  @override
  Widget build(BuildContext context) {
    return _courseDetails == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: PreferredSize(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [etfBlue, lightBlue]),
                ),
                child: AppBar(
                  backgroundColor: Color.fromRGBO(1, 1, 1, 0),
                  leading: GestureDetector(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Text(
                    _courseDetails.courseOffering.courseUnit.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                ),
              ),
              preferredSize: new Size(MediaQuery.of(context).size.width, 60),
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Semestar: ' +
                              _courseDetails.courseOffering.semester
                                  .toString() +
                              '.',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Bodovi: ' +
                              _courseDetails.totalScore.toStringAsFixed(2) +
                              "/" +
                              _courseDetails.possibleScore.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _courseDetails.grade == null
                              ? 'Ocjena: 5'
                              : 'Ocjena: ' + _courseDetails.grade.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Ak. godina: ' +
                              _courseDetails.courseOffering.academicYear.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          endIndent: 15,
                          thickness: 3,
                          color: etfBlue,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 10),
                  child: Text(
                    "Prisustvo",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Column(children: [
                  _attendanceActivity == null ||
                          _attendanceActivity.details == null ||
                          _attendanceActivity.details.length == 0
                      ? Center(
                          child: Text(
                            'Nema evidentiranog prisustva',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _attendanceActivity
                                .details[0].attendance.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _attendance(
                                  context,
                                  _attendanceActivity
                                      .details[0].attendance[index]);
                            },
                          ),
                        )
                ]),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: Text(
                    "Zadaće",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 150,
                  margin: EdgeInsets.only(top: 15),
                  child: _homeworkActivity == null ||
                          _homeworkActivity.details.length == 0
                      ? Center(
                          child: Text(
                            'Nema ocjenjenih zadaća',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _homeworkActivity.details.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _homework(
                                context, _homeworkActivity.details[index]);
                          },
                        ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  height: 60.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Ispiti",
                          style: Theme.of(context).textTheme.title,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                      children:
                          _examActivity == null || _examActivity.length == 0
                              ? [
                                  Center(
                                    child: Text(
                                      'Nema ocjenjenih ispita',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ]
                              : _examActivity.map((element) {
                                  return _exams(context, element);
                                }).toList()),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          );
  }

  Widget _homework(BuildContext context, Detail detail) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeworkInfoPage(detail.homework.id,
                detail.homework.courseUnit.id, _currentPerson)));
      },
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: detail.score == null
                      ? Text(
                          'Bodovi: nije ocjenjeno ',
                          style: TextStyle(
                            color: etfBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      : Text(
                          'Bodovi: ' + detail.score.toStringAsFixed(2),
                          style: TextStyle(
                            color: etfBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                ),
              ],
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              color: Color.fromRGBO(38, 38, 38, 0.5),
              child: Text(
                detail.homework.name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _attendance(BuildContext context, Attendance attendance) {
    DateTime parsedDate = DateTime.parse(attendance.zClass.dateTime);
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                image: DecorationImage(
                    image: attendance.presence == 1
                        ? Image.asset('images/attendance_ok.png').image
                        : Image.asset('images/attendance_not_ok.png').image,
                    fit: BoxFit.scaleDown)),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 100,
            height: 100,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            parsedDate.day.toString() +
                "." +
                parsedDate.month.toString() +
                "." +
                parsedDate.year.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _exams(BuildContext context, Score exam) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        elevation: 0.5,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () {},
        child: Row(
          children: <Widget>[
            Ink(
              height: 100,
              width: 100,
              child: Center(
                child: Icon(
                  FontAwesomeIcons.edit,
                  size: 50,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              exam.courseActivity.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                exam.score.toString() +
                                    '/' +
                                    exam.courseActivity.points.toString(),
                                style: TextStyle(
                                    color: etfBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ],
                        ),
                      ),
                      Icon(exam.score >= exam.courseActivity.pass
                          ? Icons.check
                          : Icons.close),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _fetchCourseDetails() async {
    var response = await ZamgerAPIService.getDetailsOfCourse(
        _currentCourse.courseOffering.courseUnit.id,
        _currentPerson.id,
        _currentCourse.courseOffering.academicYear.id);
    if (response.statusCode == 200) {
      _courseDetails = Course.fromJson(response.data);
      _courseDetails.score.forEach((score) {
        if (score.courseActivity.name == 'Prisustvo') {
          _attendanceActivity = score;
        } else if (score.courseActivity.name == 'Zadaće') {
          _homeworkActivity = score;
        } else {
          _examActivity.add(score);
        }
      });
      setState(() {});
    }
  }
}
