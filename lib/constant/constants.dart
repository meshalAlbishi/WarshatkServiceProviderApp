import 'package:flutter/material.dart';

// font size
double mainTitleSize = 15;
double subTitleSize = 12;

// colors
Color mainBtnColor = const Color(0xFFdc143c).withOpacity(0.9);

// background
Color mainBackGround = const Color(0xFFdc143c).withOpacity(0.9);
Color secondaryBackGround = const Color(0xFFf2F2F2);

// padding
const double appPadding = 20.0;

void showSnackBar(String title, BuildContext context, Color color) {

  final snackbar = SnackBar(
    duration: Duration(seconds: 3),
    backgroundColor: color,
    content: Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  );

  Scaffold.of(context).showSnackBar(snackbar);
}
