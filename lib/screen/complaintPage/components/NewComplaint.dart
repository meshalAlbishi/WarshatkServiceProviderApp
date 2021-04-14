import 'package:flutter/material.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';

import 'ComplaintScreenBar.dart';
import 'ComplaintScreenBody.dart';
import 'NewComplaintBody.dart';

class NewComplaint extends StatefulWidget {
  final ServiceProvider provider;
  final List<String> requestList;

  const NewComplaint({Key key, this.provider, this.requestList})
      : super(key: key);

  @override
  _NewComplaintState createState() => _NewComplaintState();
}

class _NewComplaintState extends State<NewComplaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryBackGround,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 200,),
            ComplaintScreenBar(
                provider: widget.provider,
                title: "New Complaint",
                isAdd: false),
            NewComplaintScreenBody(
                provider: widget.provider, requestList: widget.requestList),
          ],
        ),
      ),
    );
  }
}
