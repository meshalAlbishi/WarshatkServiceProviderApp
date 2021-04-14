import 'package:flutter/material.dart';
import 'components/ComplaintScreenBar.dart';
import 'components/ComplaintScreenBody.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';

class ComplaintScreen extends StatefulWidget {
  final ServiceProvider provider;

  const ComplaintScreen({Key key, this.provider}) : super(key: key);

  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: secondaryBackGround,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ComplaintScreenBar(
              provider: widget.provider,
              title: "Complaint",
              isAdd: true,
            ),
            ComplaintScreenBody(
              provider: widget.provider,
            ),
          ],
        ),
      ),
    );
  }
}
