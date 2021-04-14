import 'package:flutter/material.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';
import 'package:service_provider_app/screen/profilePages/edit_profile_screen.dart';

class ProfileScreenBar extends StatelessWidget {
  final ServiceProvider provider;

  const ProfileScreenBar({Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: mainBackGround,
        border: Border.all(color: mainBackGround),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20.0, right: 10.0, left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // back to menu icon
            IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed: () {
                  _backToMainScreen(context);
                }),

            Text(
              "Profile",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),

            // edit profile icon
            IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 32,
                  color: Colors.white,
                ),
                onPressed: () {
                  _editPage(context);
                })
          ],
        ),
      ),
    );
  }

  _editPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => EditProfileScreen(
            provider: provider,
          )),
    );
  }

  _backToMainScreen(BuildContext context) {
    Navigator.pop(context);
    // pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => MainScreen(
    //         provider: provider,
    //       )),
    // );
  }
}
