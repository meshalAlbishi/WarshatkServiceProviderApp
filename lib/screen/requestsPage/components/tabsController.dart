import 'dart:async';
import 'newTabBody.dart';
import 'activeTabBody.dart';
import 'package:flutter/material.dart';
import 'package:service_provider_app/model/Bill.dart';
import 'package:service_provider_app/model/Request.dart';
import 'package:service_provider_app/model/Customer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';
import 'package:service_provider_app/screen/mainPage/main_screen.dart';
import 'package:service_provider_app/screen/requestsPage/components/pastTabBody.dart';

class TabsController extends StatefulWidget {
  final ServiceProvider provider;

  const TabsController({Key key, this.provider}) : super(key: key);

  @override
  _TabsControllerState createState() => _TabsControllerState();
}

class _TabsControllerState extends State<TabsController> {
  List<Request> activeRequestList = [];
  List<Request> pastRequestList = [];
  List<Request> newRequestList = [];

  final userRequestRef =
      FirebaseDatabase.instance.reference().child("Users-Requests");
  final requestRef = FirebaseDatabase.instance.reference().child("Request");
  final billRef = FirebaseDatabase.instance.reference().child("Bill");
  final customerRef = FirebaseDatabase.instance
      .reference()
      .child("users/ApplicationUsers/Customer");

  Timer _timer;

  @override
  void initState() {
    super.initState();

    // retrieve all request
    userRequestRef
        .child(widget.provider.uid)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        // clear all list
        activeRequestList.clear();
        pastRequestList.clear();
        newRequestList.clear();

        var data = snapshot.value;

        data.forEach((key, value) {
          Request req;

          requestRef
              .child(key)
              .once()
              .then((DataSnapshot requestSnapshot) async {
            var requestData = requestSnapshot.value;

            String _uid = key;
            String _requestNo = requestData['requestNo'].toString();
            String _car = requestData['carID'];

            String _details = requestData['details'];
            bool _isAccepted = requestData['isAccepted'];
            String _progress = requestData['progress'];
            DateTime _requestDate = DateTime.parse(requestData['requestDate']);
            String _status = requestData['status'];

            var _latitude = requestData['latitude'];
            var _longitude = requestData['longitude'];

            req = new Request(_uid, _requestNo, _car, _details, _isAccepted,
                _progress, _requestDate, _status, _latitude, _longitude);

            getBill(requestData['billNo'].toString(), req);
            getCustomer(requestData['customer'], req);

            if (requestSnapshot.value['status'] == 'active' ||
                requestSnapshot.value['status'] == 'pay' ||
                requestSnapshot.value['status'] == 'workshop') {
              activeRequestList.add(req);
            } else if (requestSnapshot.value['status'] == 'new') {
              newRequestList.add(req);
            } else if (requestSnapshot.value['status'] == 'closed' ||
                requestSnapshot.value['status'] == 'completed') {
              pastRequestList.add(req);
            }
          });
        }); // foreach data, data == user-request
      }
    });

    _timer = Timer(Duration(seconds: 5), () {
      setState(() {});
    });
  }

  getBill(String billUid, Request req) {
    billRef.child(billUid).once().then((DataSnapshot billSnapshot) async {
      var billData = billSnapshot.value;

      Bill bill = new Bill(
          billUid,
          billData['billNo'],
          billData['describtion'],
          billData['amount'],
          billData['isPaid'],
          DateTime.parse(billData['payDate']));

      req.bill = bill;
    });
  }

  getCustomer(String uid, Request req) {
    customerRef.child(uid).once().then((DataSnapshot snapshot) {
      String uid = snapshot.key;
      String _name = snapshot.value['name'];
      String _phone = snapshot.value['phone'];
      String _city = snapshot.value['city'];

      var _rating = snapshot.value['rating'];
      Customer c = new Customer(uid, _name, _phone, _city, _rating);
      req.customer = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBar(),
        body: tabsBody(),
      ),
    );
  }

  appBar() {
    return AppBar(
      leading: menuIcon(),
      title: title(),
      elevation: 0,
      backgroundColor: mainBackGround,
      bottom: tabsTitle(),
    );
  }

  // appbar menu icon widget
  menuIcon() {
    return IconButton(
        icon: Icon(
          Icons.menu,
          size: 35,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainScreen(
                      provider: widget.provider,
                    )),
          );
        });
  }

  // title widget
  title() {
    return Container(
      margin: EdgeInsets.only(left: 100),
      child: Text("Request"),
    );
  }

  // tabs title
  tabsTitle() {
    return TabBar(
      unselectedLabelColor: Colors.white,
      labelColor: mainBackGround,
      indicator: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Colors.white),
      tabs: [
        _addTab("Active"),
        _addTab("New"),
        _addTab("Past"),
      ],
    );
  }

  // add single with title for it
  Tab _addTab(String tabName) {
    return Tab(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          tabName,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  // tabs body
  tabsBody() {
    return TabBarView(
      children: <Widget>[
        ActiveRequest(
            provider: widget.provider, requestList: activeRequestList),
        NewRequest(provider: widget.provider, requestList: newRequestList),
        PastRequest(provider: widget.provider, requestList: pastRequestList),
      ],
    );
  }
}
