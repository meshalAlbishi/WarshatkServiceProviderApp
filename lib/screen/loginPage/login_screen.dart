import 'components/LoginBody.dart';
import 'components/CircleButton.dart';
import 'package:flutter/material.dart';
import 'components/BackgroundImage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // title and logo
                BackgroundImage(),

                // login body
                LoginBody(),
              ],
            ),

            // circle button -> back to home page
            CircleButton(),
          ],
        ),
      ),
    );
  }
}
