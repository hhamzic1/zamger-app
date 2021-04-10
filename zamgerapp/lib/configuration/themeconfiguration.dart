import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryGreen = Color(0xff416d6d);
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];

List<Map> drawerItems = [
  {'icon': FontAwesomeIcons.houseUser, 'title': 'Početna'},
  {'icon': Icons.inbox, 'title': 'Inbox'},
  {'icon': FontAwesomeIcons.pen, 'title': 'Ispiti'},
  {'icon': Icons.assignment_ind_rounded, 'title': 'Zadaće'},
  {'icon': Icons.contact_mail_rounded, 'title': 'Zahtjevi'},
  {'icon': FontAwesomeIcons.userAlt, 'title': 'Moj profil'}
];
