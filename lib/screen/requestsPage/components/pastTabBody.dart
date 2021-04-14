import 'package:flutter/material.dart';
import 'package:service_provider_app/model/Request.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';

class PastRequest extends StatefulWidget {
  final ServiceProvider provider;
  final List<Request> requestList;

  PastRequest({Key key, this.provider, this.requestList}) : super(key: key);

  @override
  _PastRequestState createState() => _PastRequestState(provider, requestList);
}

class _PastRequestState extends State<PastRequest> {
  final ServiceProvider provider;
  final List<Request> requestList;

  _PastRequestState(this.provider, this.requestList);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    setState(() {});
    return Scaffold(
      backgroundColor: secondaryBackGround,
      body: requestList.length == 0
          ? Container(
              margin: EdgeInsets.only(top: 100, left: 125),
              child: Text(
                "No Request yet!",
                style: TextStyle(fontSize: 24),
              ))
          : ListView.builder(
              itemCount: requestList.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: <Widget>[
                    _requestCardInkWell(size, index),
                    Positioned(top: 20, left: 10, child: requestIcon()),
                  ],
                );
              }),
    );
  }

  // request icon
  Container requestIcon() {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: mainBackGround),
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: Icon(
        Icons.handyman,
        size: 30,
        color: mainBackGround,
      ),
    );
  }

  // main inkWell for the card as child
  InkWell _requestCardInkWell(Size size, int index) {
    return InkWell(
      child: Container(
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
        child: _mainCardBody(size, index),
      ),
      onTap: () {
        print('hi');
      },
    );
  }

  // Card Methods
  Card _mainCardBody(Size size, int index) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20, right: 8.0),
        child: Column(
          children: [
            _nameAndAmountRow(size, index),
            SizedBox(
              height: 10,
            ),
            _requestAndDateRow(size, index),
            SizedBox(
              height: 10,
            ),
            _carAndStatusRow(size, index),
          ],
        ),
      ),
    );
  }

  Row _nameAndAmountRow(Size size, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(requestList[index].customer.name,
            style: textCardStyle(mainTitleSize, Colors.black)),
        SizedBox(
          width: size.width / 3,
        ),
        Text('\$${requestList[index].bill.amount.toString()}',
            style: textCardStyle(mainTitleSize, Colors.black)),
      ],
    );
  }

  Row _requestAndDateRow(Size size, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('request# ${requestList[index].requestNo.toString()}',
            style: textCardStyle(subTitleSize, Colors.grey.shade400)),
        SizedBox(
          width: size.width / 3,
        ),
        Text('${requestList[index].requestDate.toString().substring(0, 11)}',
            style: textCardStyle(subTitleSize, Colors.grey.shade400)),
      ],
    );
  }

  Row _carAndStatusRow(Size size, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(requestList[index].car,
            style: textCardStyle(subTitleSize, Colors.black)),
        SizedBox(
          width: size.width / 3,
        ),
        Text('${requestList[index].status}',
            style: statuStyling(
                subTitleSize, requestList[index].status.toUpperCase())),
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
      case "ACTIVE":
      case "COMPLETED":
        color = Colors.green;
        break;
      // --------------
      case "NEW":
        color = Colors.orangeAccent;
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
