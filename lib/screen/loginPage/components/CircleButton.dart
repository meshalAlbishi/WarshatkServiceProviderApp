import 'package:flutter/material.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/screen/homePage/home_screen.dart';

class CircleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Positioned(
      top: size.height * 0.36,
      right: size.width * 0.19,
      child: FloatingActionButton(
        elevation: 5.0,
        backgroundColor: mainBtnColor,
        child: Icon(
          Icons.arrow_back,
          size: 30.0,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
      ),
    );
  }
}
