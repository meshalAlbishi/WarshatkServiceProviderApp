import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {

  final String hintText;
  final bool isRead;
  final TextEditingController controller;
  final double topMargin;

  ProfileTextField(
      {Key key, this.hintText, this.controller, this.topMargin, this.isRead})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: topMargin, left: 8.0, right: 8.0),
        child: _createTextField());
  }

  Widget _createTextField() {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextField(
        readOnly: isRead,
        controller: controller..text = hintText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              letterSpacing: 1.5,
              color: Colors.black54,
              fontWeight: FontWeight.bold),
          fillColor: Colors.white30,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
