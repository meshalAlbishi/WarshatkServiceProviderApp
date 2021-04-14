import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomLaunch {

  CustomLaunch._();

  static void openLaunch(command) async {
    if (await canLaunch(command)){
      await launch(command);
    }else{
      print("can't");
    }
  }
}