import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/configuration/themeconfiguration.dart';
import 'package:zamgerapp/main.dart';
import 'package:zamgerapp/models/index.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

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
                          Icon(
                            Icons.location_on,
                            color: etfBlue,
                          ),
                          Text('Bosnia and Herzegovina'),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://library.kissclipart.com/20180906/wkw/kissclipart-user-icon-png-clipart-user-profile-computer-icons-94f08bfdb73bc68b.jpg'),
                    backgroundColor: Colors.transparent,
                    radius: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1000,
              child: TextButton(
                  onPressed: () async {
                    var response =
                        await ZamgerAPIService.getRecentRecievedMessages(10);
                    Messages inbox = Messages.fromJson(response.data);
                    print(inbox.results);
                  },
                  child: Text("See tokens")),
            ),
          ],
        ),
      ),
    );
  }
}
