import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

var defaultBackgroundColor = Colors.white;
var appBarColor = Colors.grey[900];
var textColor= Colors.black;
var textColorAddMeet= Colors.black;
var primaryColor=Colors.green;
var textColorButton= Colors.white;
// ignore: non_constant_identifier_names
var IconColorHome= Colors.black;
// ignore: non_constant_identifier_names
var IconColorAddMeet= Colors.grey[700];
var drawerTextColor = TextStyle(
  color: Colors.grey[900],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);

void doShare(BuildContext context) {
  Share.share('check out my website https://example.com', subject: 'Look what I made!');
}void doNothink(BuildContext context) {
  Share.share('check out my website https://example.com', subject: 'Look what I made!');
}

getBGClr(int? color) {
  switch (color) {
    case 0:
      return Colors.blue[300];
    case 1:
      return Colors.grey;
    case 2:
      return Colors.orange;
    default:
      return Colors.pink;
  }
}