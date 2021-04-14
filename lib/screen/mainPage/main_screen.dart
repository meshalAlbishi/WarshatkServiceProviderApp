import 'package:flutter/material.dart';
import 'components/MainScreenBar.dart';
import 'components/mainScreenBody.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';

class MainScreen extends StatefulWidget {
  final ServiceProvider provider;

  const MainScreen({Key key, this.provider}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final userRequestRef =
      FirebaseDatabase.instance.reference().child("Users-Requests");

  final requestRef = FirebaseDatabase.instance.reference().child("Request");

  final billRef = FirebaseDatabase.instance.reference().child("Bill");

  final userBillRef =
      FirebaseDatabase.instance.reference().child("Users-Bills");

  @override
  void initState() {

    super.initState();
    newRequestListener(context);
  }

  newRequestListener(BuildContext context) {
    userRequestRef
        .child(widget.provider.uid)
        .orderByValue()
        .equalTo("true")
        .onChildAdded
        .listen((Event event) {

      print(event.snapshot.key);
      requestRef
          .child(event.snapshot.key)
          .once()
          .then((DataSnapshot requestSnapshot) async {
        var requestData = requestSnapshot.value;

        String _uid = event.snapshot.key;
        String _billUID = requestData['billNo'];
        String _car = requestData['carID'];
        String _details = requestData['details'];

        _showMyDialog(_uid,_billUID, _car, _details, context);
      });
    }, onError: (Object o) {
      DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');
    });
  }

  void _showMyDialog(
      String _uid,String _billUID, String _car, String _details, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Request Received!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Car Info: ' + _car.replaceAll("-", " "),
                    style: TextStyle(fontSize: 18, color: Colors.black)),
                SizedBox(height: 12),
                Text('Details: ' + _details,
                    style: TextStyle(fontSize: 18, color: Colors.black)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Accept',
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
              onPressed: () {
                acceptRejectRequest(_uid,_billUID, "active", true);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Reject',
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
              onPressed: () {
                acceptRejectRequest(_uid,_billUID, "rejected", false);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // general method update the new request status to rejected or accepted
  acceptRejectRequest(String requestUid,String _billUID, String status, bool isAccepted) {
    requestRef.child(requestUid).update({"status": status, "isAccepted": isAccepted});
    userRequestRef.child(widget.provider.uid).update({requestUid: "false"});
    if (isAccepted) {
      createBill(requestUid, _billUID);
    }
  }

  void createBill(String uid, String _billUID) {
    String now = DateTime.now().toString();
    userBillRef.child('${widget.provider.uid}').update({_billUID: "false"});
  }

  @override
  Widget build(BuildContext context) {
    // newRequestListener(context);

    return Scaffold(
      backgroundColor: secondaryBackGround,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MainScreenBar(provider: widget.provider),
            MainScreenBody(provider: widget.provider),
          ],
        ),
      ),
    );
  }
}
