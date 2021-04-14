import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';
import 'package:service_provider_app/screen/mainPage/main_screen.dart';

import '../complaint_screen.dart';
import 'NewComplaint.dart';

class ComplaintScreenBar extends StatefulWidget {
  final ServiceProvider provider;
  final String title;
  final bool isAdd;

  ComplaintScreenBar({Key key, this.provider, this.title, this.isAdd})
      : super(key: key);

  @override
  _ComplaintScreenBarState createState() => _ComplaintScreenBarState();
}

class _ComplaintScreenBarState extends State<ComplaintScreenBar> {
  final userRequestRef =
      FirebaseDatabase.instance.reference().child("Users-Requests");

  final requestRef = FirebaseDatabase.instance.reference().child("Request");

  List<String> requestList = [];

  void getAllRequestNumber() {
    userRequestRef.child(widget.provider.uid).once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        var data = snapshot.value;

        data.forEach((key, value) {
          requestRef
              .child(key)
              .once()
              .then((DataSnapshot requestSnapshot) async {
            var requestData = requestSnapshot.value;
            String _requestNo = requestData['requestNo'].toString();
            requestList.add(_requestNo);
          });
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    getAllRequestNumber();

    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
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
              widget.title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),

            !widget.isAdd
                ? SizedBox(width: 70)
                : IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewComplaint(
                                provider: widget.provider, requestList: requestList)),
                      );
                    }),
          ],
        ),
      ),
    );
  }

  _backToMainScreen(BuildContext context) {
    if (widget.isAdd) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(provider: widget.provider)),
      );
    }else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ComplaintScreen(provider: widget.provider)),
      );
    }
  }
}
