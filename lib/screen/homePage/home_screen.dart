import 'package:flutter/material.dart';
import 'components/BackgroundImage.dart';
import 'package:service_provider_app/screen/homePage/components/HomePageBody.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BackgroundImage(),
          HomePageBody(),
        ],
      ),
    );
  }
}
