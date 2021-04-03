import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.pink,
                    Colors.red,
                  ],
                  begin: Alignment.center,
                  end: Alignment.centerRight,
                  stops: [0.5, 03]),
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: AppBar(
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.settings),
                      )
                    ],
                    backgroundColor: Colors.transparent,
                    title: Text("Elise Remmi"),
                    centerTitle: true,
                    elevation: 0,
                    leading: GestureDetector(
                      child: Icon(Icons.arrow_back_ios),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SwipeDetector(
                    onSwipeLeft: () {
                      print("left");
                    },
                    onSwipeRight: () {
                      print("Right");
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: ListView(
                        children: [
                          senderDetails("Elise Remmi", 0123456789, "22:35",
                              "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"),
                          message(
                              "Aliright sir, tommorow I will come with my friend and get some nuggets in your table.",
                              "not me"),
                          receiverDetails("Me", 9876543210, "22:45",
                              "https://img.freepik.com/free-psd/young-hipster-man-with-his-arms-crossed_1368-25112.jpg?size=338&ext=jpg"),
                          message(
                              "Thsi will be really a great paltforma nf a dmeeting wher  jknr jnionfg jkohnfio nioejfiopmlk fiojodc m jkoniofmniofnmknbkgbnuiognjekgnnvo noi oi fjoi nfonrothoijhf hfroinoirfgjeiofvnrotnmk g jior jrio",
                              "sent"),
                          senderDetails("Elise Remmi", 0123456789, "22:35",
                              "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"),
                          message(
                              "Aliright sir, tommorow I will come with my friend and get some nuggets in your table.",
                              "not me"),
                          receiverDetails("Me", 9876543210, "22:45",
                              "https://img.freepik.com/free-psd/young-hipster-man-with-his-arms-crossed_1368-25112.jpg?size=338&ext=jpg"),
                          message(
                              "Thsi will be really a great paltforma nf a dmeeting wher  jknr jnionfg jkohnfio nioejfiopmlk fiojodc m jkoniofmniofnmknbkgbnuiognjekgnnvo noi oi fjoi nfonrothoijhf hfroinoirfgjeiofvnrotnmk g jior jrio",
                              "sent"),
                          senderDetails("Elise Remmi", 0123456789, "22:35",
                              "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"),
                          message(
                              "Aliright sir, tommorow I will come with my friend and get some nuggets in your table.",
                              "not me"),
                          receiverDetails("Me", 9876543210, "22:45",
                              "https://img.freepik.com/free-psd/young-hipster-man-with-his-arms-crossed_1368-25112.jpg?size=338&ext=jpg"),
                          message(
                              "Thsi will be really a great paltforma nf a dmeeting wher  jknr jnionfg jkohnfio nioejfiopmlk fiojodc m jkoniofmniofnmknbkgbnuiognjekgnnvo noi oi fjoi nfonrothoijhf hfroinoirfgjeiofvnrotnmk g jior jrio",
                              "sent"),
                          SizedBox(height: 80)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 35,
            child: Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                height: 50,
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text("Write messages . . .",
                          style: TextStyle(
                            letterSpacing: -0.3,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.send, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget senderDetails(name, contactNumber, time, imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        height: 65,
        child: Row(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl),
                ),
                shape: BoxShape.circle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    contactNumber.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  time,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget receiverDetails(name, contactNumber, time, imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        height: 65,
        child: Row(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                time,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        contactNumber.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// condition here will be either sent or recieved
  Widget message(message, condition) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 4,
        bottom: 4,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink,
              Colors.pink[400],
            ],
          ),
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Text(
              message,
              textAlign: condition == "sent" ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
