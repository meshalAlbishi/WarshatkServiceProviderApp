import 'package:flutter/material.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';
import 'package:service_provider_app/screen/requestsPage/request_screen.dart';
import 'package:service_provider_app/screen/paymenetPage/payment_screen.dart';
import 'package:service_provider_app/screen/complaintPage/complaint_screen.dart';
import 'package:service_provider_app/screen/profilePages/main_profile_screen.dart';

class BottomSideBody extends StatefulWidget {
  final ServiceProvider provider;

  const BottomSideBody({Key key, this.provider}) : super(key: key);

  @override
  _BottomSideBodyState createState() => _BottomSideBodyState(provider);
}

class _BottomSideBodyState extends State<BottomSideBody> {
  final ServiceProvider provider;

  _BottomSideBodyState(this.provider);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 130.0, right: 25.0, left: 25.0),
      child: Container(
        width: double.infinity,
        height: 380.0,
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
          children: <Widget>[
            // first row
            firstRow(),
            // second row
            secondRow(),
          ],
        ),
      ),
    );
  }

  // add rows
  Padding firstRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // request icon
          createIcon("Request", Colors.green.withOpacity(0.4),
              Icon(Icons.receipt), Colors.green),
          // payment icon
          createIcon("Payment", Colors.blue.withOpacity(0.4),
              Icon(Icons.credit_card), Colors.blue.shade700),
        ],
      ),
    );
  }

  Padding secondRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Complaint icon
          createIcon("Complaint", Colors.orange.withOpacity(0.3),
              Icon(Icons.report_problem), Colors.orange),

          // profile icon
          createIcon("Profile", Colors.pink.withOpacity(0.6),
              Icon(Icons.account_circle), Colors.white),
        ],
      ),
    );
  }

  // styling
  TextStyle menuTextStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    );
  }

  // creation
  createIcon(String title, Color bg, Icon icons, Color iconColor) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(100.0),
          color: bg,
          child: IconButton(
            padding: EdgeInsets.all(15.0),
            icon: icons,
            iconSize: 30.0,
            color: iconColor,
            onPressed: () {
              makeActionOnClick(title);
            },
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          style: menuTextStyle(),
        ),
      ],
    );
  }

  // on click function to navigate to correct page
  void makeActionOnClick(String title) {
    switch (title) {
      case "Request":
        _requestPage();
        break;
      // ------------
      case "Payment":
        _paymentPage();
        break;
      // ------------
      case "Profile":
        _profilePage();
        break;
      // ------------
      case "Complaint":
        _complaintPage();
        break;
      // ------------
    }
  }

  // page navigators
  void _requestPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RequestScreen(
                provider: provider,
              )),
    );
  }

  void _paymentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentScreen(provider: provider)),
    );
  }

  void _complaintPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ComplaintScreen(provider: provider)),
    );
  }

  void _profilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileScreen(provider: provider)),
    );
  }
}
