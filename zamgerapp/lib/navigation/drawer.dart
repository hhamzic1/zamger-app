import 'package:flutter/material.dart';
import 'package:zamgerapp/ZamgerAPI/secure_storage.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/configuration/themeconfiguration.dart';
import 'package:zamgerapp/models/index.dart';
import 'package:zamgerapp/navigation/messaging/inbox_screen.dart';
import 'package:zamgerapp/navigation/other_screen.dart';

import 'certificates/certificates_screen.dart';
import 'exams/active_exams_screen.dart';
import 'homeworks/homeworks_screen.dart';
import 'login/login_screen.dart';
import 'my_study/my_study_screen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String _nameSurname = "Zamger";
  Person _currentPerson;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserNameSurname();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [lightBlue, etfBlue]),
      ),
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://library.kissclipart.com/20180906/wkw/kissclipart-user-icon-png-clipart-user-profile-computer-icons-94f08bfdb73bc68b.jpg'),
                  backgroundColor: Colors.transparent,
                  radius: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _nameSurname,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 60),
            Column(
              children: drawerItems
                  .map((element) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(
                              element['icon'],
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                              child: Text(element['title'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              onPressed: () => {
                                if (element['title'] == 'Inbox')
                                  {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Inbox()))
                                  }
                                else if (element['title'] == 'Zahtjevi')
                                  {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CertificatesPage(
                                                    _currentPerson)))
                                  }
                                else if (element['title'] == 'Zadaće')
                                  {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeworksPage(_currentPerson)))
                                  }
                                else if (element['title'] == 'Moj studij')
                                  {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyStudyPage(_currentPerson)))
                                  }
                                else if (element['title'] == 'Ispiti')
                                  {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ActiveExamsPage(
                                                    _currentPerson)))
                                  }
                                else
                                  {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OtherScreen()))
                                  }
                              },
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Postavke',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 2,
                  height: 20,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () async {
                    await Credentials.deleteTokens();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                  child: Text(
                    'Odjavi se',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _fetchUserNameSurname() async {
    var response = await ZamgerAPIService.currentPerson();
    Person person = Person.fromJson(response.data);
    setState(() {
      _currentPerson = person;
      _nameSurname = person.name + " " + person.surname;
    });
  }
}
