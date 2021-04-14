import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';

import '../complaint_screen.dart';

class NewComplaintScreenBody extends StatefulWidget {
  static String dropdownValue = '0';
  final ServiceProvider provider;
  final List<String> requestList;

  const NewComplaintScreenBody({Key key, this.provider, this.requestList})
      : super(key: key);

  @override
  _NewComplaintScreenBodyState createState() => _NewComplaintScreenBodyState();
}

class _NewComplaintScreenBodyState extends State<NewComplaintScreenBody> {
  TextEditingController detailsController = new TextEditingController();
  int _groupValue = -1;
  String _type = "";

  final DatabaseReference userComplaintRef =
      FirebaseDatabase.instance.reference().child("Users-Complaint");

  final complaintRef = FirebaseDatabase.instance.reference().child("Complaint");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 40.0, right: 15.0, left: 15.0),
      padding: EdgeInsets.only(right: 15.0, left: 15.0),
      // margin: EdgeInsets.all(15),
      width: double.infinity,
      height: 530.0,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0.0, 3.0),
              blurRadius: 15.0)
        ],
      ),

      child: Column(
        children: [

          SizedBox(height: 30),

          complaintType(),

          SizedBox(height: 30),

          // request no
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: mainBackGround, width: 1.5)),
            child: Expanded(
              child: Row(
                children: [
                  Text("Request No: ", style: TextStyle(fontSize: 22)),
                  SizedBox(width: 20),
                  MyStatefulWidget(
                    requestList: widget.requestList,
                  )
                ],
              ),
            ),
          ),

          SizedBox(height: 30),

          details(),

          SizedBox(height: 30),

          complaintButton(size)
        ],
      ),
    );
  }

  complaintType() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(7)),
          border: Border.all(color: mainBackGround, width: 1.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Complaint Type",
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _myRadioButton(title: "Application", value: 1),
              Text(
                "Application",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: 40,
              ),
              _myRadioButton(title: "Request", value: 2),
              Text(
                "Request",
                style: TextStyle(fontSize: 18),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _myRadioButton({String title, int value}) {
    return Radio(
      value: value,
      groupValue: _groupValue,
      onChanged: (value) {
        setState(() {
          _groupValue = value;
        });

        _type = (value == 1 ? "Application" : "Request");
      },
      // title: Text(title),
    );
  }

  details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Details", style: TextStyle(fontSize: 22)),
        SizedBox(height: 10),
        TextField(
          controller: detailsController,
          maxLines: 5,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: mainBackGround, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
        ),
      ],
    );
  }

  complaintButton(Size size) {
    return InkWell(
      onTap: () async {
        sendComplaint();
      },
      child: Material(
        elevation: 5.0,
        color: mainBtnColor,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: size.width * 0.7,
          height: size.height * 0.07,
          child: Center(
            child: Text(
              "Send Complaint",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  void sendComplaint() {
    try {
      String now = DateTime.now().toString();
      DatabaseReference newComplaint = complaintRef.push();
      newComplaint.update({
        "complaintDate": now,
        "complaintNo": now.substring(now.indexOf(".") + 1),
        "details": detailsController.text,
        "isResponsed": false,
        "response": " ",
        "status": "new",
        "type": _type,
        "requestNo": _groupValue == 1
            ? "0"
            : (widget.requestList.length == 0
                ? "0"
                : NewComplaintScreenBody.dropdownValue),
        "userUid": widget.provider.uid
      });

      userComplaintRef
          .child(widget.provider.uid)
          .update({newComplaint.key: "false"});

      showSnackBar("Complaint Send!", context, Colors.green);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ComplaintScreen(provider: widget.provider),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}

class MyStatefulWidget extends StatefulWidget {
  final List<String> requestList;

  const MyStatefulWidget({Key key, this.requestList}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.requestList.length <= 0
          ? Text("No Request Available")
          : DropdownButton<String>(
              hint: Text(
                NewComplaintScreenBody.dropdownValue.isEmpty
                    ? ""
                    : NewComplaintScreenBody.dropdownValue.toString(),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              // value: NewComplaintScreenBody.dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              // iconSize: 16,
              // elevation: 10,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  NewComplaintScreenBody.dropdownValue = newValue;
                });
              },
              items: widget.requestList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  // value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
    );
  }
}
