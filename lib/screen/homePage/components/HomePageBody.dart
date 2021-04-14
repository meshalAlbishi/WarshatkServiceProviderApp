import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/screen/loginPage/login_screen.dart';

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.symmetric(horizontal: appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // to give space between fields
            SizedBox(
              height: size.height * 0.04,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text(
                "Welcome Service Provider!",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),

            // to give space between fields
            SizedBox(
              height: size.height * 0.08,
            ),

            // login button
            createButton("Login", size, context),

            // to give space between fields
            SizedBox(
              height: size.height * 0.03,
            ),

            // register button
            createButton("Register", size, context),
          ],
        ));
  }

  // create button
  InkWell createButton(String text, Size size, BuildContext context) {
    return InkWell(
      onTap: () {
        if (text == "Login") {
          _loginPage(context);
        } else {
          _register();
        }
      },
      child: Material(
        elevation: 10.0,
        color: mainBtnColor,
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          width: size.height,
          height: size.height * 0.07,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  _loginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // register function
  _register() {
    _launchURL();
  }

  _launchURL() async {
    const url = 'https://infallible-swirles-d108bf.netlify.app/html/homepage/register';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
