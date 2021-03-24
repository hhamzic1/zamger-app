import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamgerapp/configuration/themeconfiguration.dart';
import 'package:zamgerapp/navigation/other_screen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[900],
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
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
                    'Huso Hamzić',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              )
            ],
          ),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Screen2()))
                            },
                          ),
                        ],
                      ),
                    ))
                .toList(),
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
              Text(
                'Odjavi se',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
