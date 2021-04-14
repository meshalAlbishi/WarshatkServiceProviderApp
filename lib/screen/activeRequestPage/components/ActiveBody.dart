import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:service_provider_app/model/Request.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';

class ActiveBody extends StatefulWidget {
  final Request request;
  final ServiceProvider provider;

  const ActiveBody({Key key, this.request, this.provider}) : super(key: key);

  @override
  _ActiveBodyState createState() => _ActiveBodyState();
}

class _ActiveBodyState extends State<ActiveBody> {
  TextEditingController detailsController = new TextEditingController();
  TextEditingController progressController = new TextEditingController();

  TextEditingController amountController = new TextEditingController();
  TextEditingController billController = new TextEditingController();

  DatabaseReference requestRef =
      FirebaseDatabase.instance.reference().child("Request");

  DatabaseReference billRef =
      FirebaseDatabase.instance.reference().child("Bill");

  DatabaseReference userBillRef =
      FirebaseDatabase.instance.reference().child("Users-Bills");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          // // call, map, and chat buttons
          // buttons(),
          SizedBox(height: 20),

          customerCarRow(size.width / 2.5),

          SizedBox(height: 30),

          // details area
          details(size.width),

          SizedBox(height: 30),

          // progress area
          progress(),

          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                progressButton(size),
                SizedBox(width: 10),
                billButton(size),
                SizedBox(width: 10),
                completeButton(size),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // progress method
  progress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Progress", style: TextStyle(fontSize: 22)),
        SizedBox(height: 10),
        TextField(
          controller: progressController,
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

  progressButton(size) {
    return InkWell(
      onTap: () async {
        updateProgress();
      },
      child: Material(
        elevation: 5.0,
        // color: mainBtnColor,
        color: Color(0xFFc63a55),
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: 100,
          height: size.height * 0.07,
          child: Center(
            child: Text(
              "Update",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  void updateProgress() {
    print("hi");
    widget.request.progress = progressController.text;

    print(progressController.text);
    print(widget.request.progress);

    requestRef
        .child(widget.request.uid)
        .update({"progress": widget.request.progress});

    showSnackBar("Progress Updated", context, Colors.green);
  }

  // bill methods
  billButton(size) {
    return InkWell(
      onTap: () {
        billAlert();
      },
      child: Material(
        elevation: 5.0,
        // color: mainBtnColor,
        color: mainBackGround,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: 100,
          height: size.height * 0.07,
          child: Center(
            child: Text(
              "Bill",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  billAlert() {
    return Alert(
        context: context,
        title: "Bill#${widget.request.bill.billNo}",
        content: Container(
          margin: EdgeInsets.only(top: 25),
          child: Column(
            children: <Widget>[
              // amount text field
              TextField(
                keyboardType: TextInputType.number,

                controller: amountController
                  ..text = widget.request.bill.amount.toString(),

                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainBackGround, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),

                    contentPadding: EdgeInsets.all(10),

                    icon: Icon(
                      Icons.attach_money,
                      color: mainBackGround,
                      size: 30,
                    ),

                    labelText: 'amount',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
              ),

              SizedBox(
                height: 30,
              ),

              // details text field
              TextField(
                maxLines: 5,
                controller: billController
                  ..text = widget.request.bill.describtion,

                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainBackGround, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),

                  contentPadding: EdgeInsets.all(10),
                  icon: Icon(
                    Icons.lock,
                    color: mainBackGround,
                    size: 30,
                  ),

                  labelText: 'Bill Detail',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
        ),

        buttons: [

          DialogButton(
            color: mainBackGround,
            onPressed: () {
              updateBill();
            },
            child: Text(
              "Update Bill",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )

        ]).show();

  }

  void updateBill() {
    // updating the bill object in the current request
    widget.request.bill.describtion = billController.text;
    widget.request.bill.amount = double.parse(amountController.text);

    billRef.child(widget.request.bill.uid).update({
      "amount": widget.request.bill.amount,
      "describtion": widget.request.bill.describtion
    });

    showSnackBar("Bill updated!", context, Colors.green);

  }

  // complete methods
  completeButton(size) {
    return InkWell(
      onTap: () {
        updateCompleteStatus();
        // Timer.
        Navigator.pop(context);
      },
      child: Material(
        elevation: 5.0,
        color: mainBtnColor,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: 100,
          height: size.height * 0.07,
          child: Center(
            child: Text(
              "Complete",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  void updateCompleteStatus() {
    widget.request.status = 'pay';
    requestRef.child(widget.request.uid).update({"status": "pay"});
    billRef.child('${widget.request.bill.uid}').update({
      "amount": widget.request.bill.amount,
      "describtion": widget.request.bill.describtion
    });

    showSnackBar("The Bill was send! \n Please wait for the customer", context, Colors.green);
  }

// ----------------------------------------

  customerCarRow(double width) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(7)),
          border: Border.all(color: mainBackGround, width: 1.5)),
      child: Row(
        children: [
          // customer info
          Icon(Icons.account_circle, color: mainBackGround),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              widget.request.customer.name,
              style: TextStyle(fontSize: 17),
            ),
          ),

          SizedBox(width: 80),

          // car info
          Icon(Icons.directions_car, color: mainBackGround),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              widget.request.car
                  .substring(widget.request.car.indexOf("-") + 1)
                  .replaceAll("-", " "),
              style: TextStyle(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }

  details(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Details", style: TextStyle(fontSize: 22)),
        SizedBox(height: 10),
        Container(
          width: width,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(7)),
              border: Border.all(color: mainBackGround, width: 1.5)),
          child: Text(
            widget.request.details,
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }

}

// unused
// Row buttons() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       // map button
//       FloatingActionButton(
//         heroTag: null,
//         elevation: 5.0,
//         backgroundColor: mainBtnColor,
//         child: Icon(
//           Icons.directions,
//           size: 30.0,
//         ),
//         onPressed: () {
//           MapUtils.openMap(widget.request.latitude, widget.request.longitude);
//         },
//       ),
//
//       SizedBox(width: 35),
//
//       // call button
//       FloatingActionButton(
//         heroTag: null,
//         elevation: 5.0,
//         backgroundColor: mainBtnColor,
//         child: Icon(
//           Icons.call,
//           size: 30.0,
//         ),
//         onPressed: () {
//           CustomLaunch.openLaunch("tel:${widget.provider.phone}");
//         },
//       ),
//
//       SizedBox(width: 35),
//
//       // chat button
//       FloatingActionButton(
//         heroTag: null,
//         elevation: 5.0,
//         backgroundColor: mainBtnColor,
//         child: Icon(
//           Icons.chat,
//           size: 30.0,
//         ),
//         onPressed: () {
//           CustomLaunch.openLaunch("tel:${widget.provider.phone}");
//         },
//       ),
//     ],
//   );
// }
