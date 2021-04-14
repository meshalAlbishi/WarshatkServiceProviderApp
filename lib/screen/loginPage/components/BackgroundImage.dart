import 'CurvedClipper.dart';
import 'package:flutter/material.dart';
import 'package:service_provider_app/constant/constants.dart';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ClipPath(
      clipper: CurvedClipper(),
      child: Container(
        height: size.width * 0.85,
        // color: Color(0xFFedf2ff),
        color: Colors.blueGrey.shade300,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: appPadding / 2, vertical: appPadding / 4),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Center(
                child: Image(
                  image: AssetImage("images/towing_car.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
