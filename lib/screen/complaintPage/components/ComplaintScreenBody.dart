import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_provider_app/constant/CustomLoader.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/Complaint.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';

class ComplaintScreenBody extends StatefulWidget {
  final ServiceProvider provider;

  // final List<Complaint> complaintList;

  const ComplaintScreenBody({Key key, this.provider}) : super(key: key);

  @override
  _ComplaintScreenBodyState createState() => _ComplaintScreenBodyState();
}

class _ComplaintScreenBodyState extends State<ComplaintScreenBody> {
  final DatabaseReference userComplaintRef =
      FirebaseDatabase.instance.reference().child("Users-Complaint");

  final complaintRef = FirebaseDatabase.instance.reference().child("Complaint");

  List<Complaint> complaintList = [];
  bool isFirstTime = true;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    // retrieve all complaints
    getAllComplaint();

    _timer = Timer(Duration(seconds: 3), () {
      setState(() {
        complaintList = complaintList;
        isFirstTime = false;
      });
    });
  }

  void getAllComplaint() {
    userComplaintRef
        .child(widget.provider.uid)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        // clear all list
        complaintList.clear();

        var data = snapshot.value;

        data.forEach((key, value) {
          Complaint complaint;

          complaintRef
              .child(key)
              .once()
              .then((DataSnapshot requestSnapshot) async {
            var complaintData = requestSnapshot.value;
            print(complaintData);
            String _uid = key;

            String _complaintNo = complaintData['complaintNo'].toString();
            DateTime _complaintDate =
                DateTime.parse(complaintData['complaintDate']);
            String _details = complaintData['details'];
            bool _isResponsed = complaintData['isResponsed'];
            String _requestNo = complaintData['requestNo'].toString();
            String _response = complaintData['response'];
            String _status = complaintData['status'];
            String _type = complaintData['type'];

            complaint = new Complaint(
                _uid,
                _complaintNo,
                _details,
                _complaintDate,
                _isResponsed,
                _requestNo,
                _status,
                _type,
                _response);

            complaintList.add(complaint);
          });
        }); // foreach data, data == user-complaint/uid
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height*0.9,
      color: secondaryBackGround,
      child: isFirstTime
          ? CustomLoader()
          : complaintList.length == 0
          ? Container(
              // height: 150,
              margin: EdgeInsets.only(top: 100, left: 30),
              child: Text(
                "No Complaint",
                style: TextStyle(fontSize: 26),
              ))
          : Container(
              // margin: EdgeInsets.only(top: 55),
              width: size.width,
              height: 450,
              child: ListView.builder(
                  itemCount: complaintList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: <Widget>[
                        _requestCard(size, index),
                        Positioned(top: 20, left: 10, child: complaintIcon()),
                      ],
                    );
                  }),
            ),
    );
  }

  // complaint icon
  Container complaintIcon() {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: mainBackGround),
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: Icon(
        Icons.warning_amber_outlined,
        size: 30,
        color: mainBackGround,
      ),
    );
  }

  // main inkWell for the card as child
  _requestCard(Size size, int index) {
    return Container(
      margin: EdgeInsets.only(left: 40.0, top: 5, right: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0.0, 3.0),
              blurRadius: 15.0)
        ],
      ),
      height: 90.0,
      child: _mainCardBodyInkWell(size, index),
    );
  }

  // Card Methods
  _mainCardBodyInkWell(Size size, int index) {
    return InkWell(
      child: Card(
        color: Colors.white,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 20, right: 8.0),
          child: Column(
            children: [
              _complaintAndStatusRow(size, index),
              SizedBox(
                height: 20,
              ),
              _responseAndDateRow(size, index),
            ],
          ),
        ),
      ),
      onTap: () {
        print("in");
        // return _showMyDialog(index);
      },
    );
  }

  // card body rows
  Row _complaintAndStatusRow(Size size, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Complaint# ${complaintList[index].complaintNo.toString()}',
            style: textCardStyle(mainTitleSize, Colors.black)),
        SizedBox(
          width: size.width / 3,
        ),
        Text('${complaintList[index].status.toUpperCase()}',
            style: statuStyling(
                mainTitleSize, complaintList[index].status.toUpperCase())),
      ],
    );
  }

  Row _responseAndDateRow(Size size, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
            '${complaintList[index].complaintDate.toString().substring(0, 11)}',
            style: textCardStyle(mainTitleSize, Colors.black)),
        SizedBox(
          width: size.width / 3,
        ),
        Text('${complaintList[index].isRespond ? "Respond" : "No Respond"}',
            style: statuStyling(
                mainTitleSize,
                (complaintList[index].isRespond ? "Respond" : "No Respond")
                    .toUpperCase())),
      ],
    );
  }

  // card text styling
  textCardStyle(double fontSize, Color color) {
    return TextStyle(
        fontSize: fontSize, color: color, fontWeight: FontWeight.bold);
  }

  statuStyling(double fontSize, String status) {
    Color color;
    switch (status) {
      case "FINISHED":
        color = Colors.green;
        break;
      // --------------
      case "NEW":
        color = Colors.orangeAccent;
        break;
      // --------------
      case "Responded":
      case "Respond":
        color = Colors.blue;
        break;
      // --------------
      default:
        color = Colors.red;
        break;
      // --------------
    }

    return TextStyle(
        fontSize: fontSize, color: color, fontWeight: FontWeight.bold);
  }
}
