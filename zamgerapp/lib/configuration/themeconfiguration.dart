import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color etfBlue = Color.fromARGB(255, 2, 102, 174);
Color lightBlue = Color.fromARGB(255, 148, 211, 255);

List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];

List<Map> drawerItems = [
  {'icon': FontAwesomeIcons.houseUser, 'title': 'Početna'},
  {'icon': Icons.inbox, 'title': 'Inbox'},
  {'icon': FontAwesomeIcons.pen, 'title': 'Ispiti'},
  {'icon': Icons.assignment_ind_rounded, 'title': 'Zadaće'},
  {'icon': Icons.contact_mail_rounded, 'title': 'Zahtjevi'},
  {'icon': FontAwesomeIcons.graduationCap, 'title': 'Moj studij'}
];
