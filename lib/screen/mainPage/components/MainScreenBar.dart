import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';
import 'package:service_provider_app/screen/loginPage/login_screen.dart';

class MainScreenBar extends StatelessWidget {

  final ServiceProvider provider;

  const MainScreenBar({Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: mainBackGround,
        border: Border.all(color: mainBackGround),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 30.0, right: 15.0, left: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(),

            // sign out button
            IconButton(
                icon: Icon(
                  Icons.logout,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed: () {
                  signOut(context);
                })

          ],
        ),
      ),
    );
  }

  signOut(BuildContext context) {

    provider.providerRef.update({
      'appActivity' : "inactive"
    });

    FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );

  }
}
