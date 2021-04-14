import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:service_provider_app/model/Request.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';
import 'package:service_provider_app/constant/CustomLaunch.dart';

class ActiveBodyBar {
  Widget build(
      BuildContext context, Request request, ServiceProvider provider) {
    return AppBar(
      backgroundColor: mainBackGround,
      leading: // back to menu icon
          IconButton(
              icon: Icon(
                Icons.menu,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () {
                _backToMainScreen(context);
              }),
      title: Center(
        child: Text(
          "#${request.requestNo}",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      actions: [PopupOptionMenu(request, provider)],
    );
  }

  _backToMainScreen(BuildContext context) {
    Navigator.pop(context);
  }
}

class PopupOptionMenu extends StatelessWidget {
  final ServiceProvider provider;
  final Request request;
  final DatabaseReference requestRef =
      FirebaseDatabase.instance.reference().child("Request");

  PopupOptionMenu(this.request, this.provider);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (BuildContext context) {
      return <PopupMenuEntry<String>>[
        // call
        PopupMenuItem(
            value: "Call",
            child: InkWell(
              child: Row(
                children: [
                  Icon(Icons.call, color: mainBackGround),
                  SizedBox(width: 15),
                  Text("Call"),
                ],
              ),
              onTap: () {
                CustomLaunch.openLaunch("tel:${provider.phone}");
              },
            )),
        // chat
        // PopupMenuItem(
        //   value: "Chat",
        //   child: InkWell(
        //     child: Row(
        //       children: [
        //         Icon(Icons.chat, color: mainBackGround),
        //         SizedBox(width: 15),
        //         Text("Chat"),
        //       ],
        //     ),
        //     onTap: () {
        //       // chat page
        //       // CustomLaunch.openLaunch("tel:${provider.phone}");
        //     },
        //   ),
        // ),
        // repair
        PopupMenuItem(
          value: "Repair",
          child: InkWell(
            child: Row(
              children: [
                Icon(
                  Icons.car_repair,
                  color: mainBackGround,
                  size: 30,
                ),
                SizedBox(width: 15),
                Text("Repair"),
              ],
            ),
            onTap: () {
              moveToWorkshop(context);
            },
          ),
        )
      ];
    });
  }

  void moveToWorkshop(BuildContext context) {
    requestRef.child(request.uid).update({"status": "workshop"});
    showSnackBar("Customer Notified!", context, Colors.green);
  }
}
