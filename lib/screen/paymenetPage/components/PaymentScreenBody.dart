import 'dart:async';
import 'package:flutter/material.dart';
import 'package:service_provider_app/model/Bill.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';
import 'package:service_provider_app/constant/CustomLoader.dart';

class PaymentScreenBody extends StatefulWidget {
  final ServiceProvider provider;

  const PaymentScreenBody({Key key, this.provider}) : super(key: key);

  @override
  _PaymentScreenBodyState createState() => _PaymentScreenBodyState();
}

class _PaymentScreenBodyState extends State<PaymentScreenBody> {
  _PaymentScreenBodyState();

  bool _disposed = false;
  List<Bill> billList = List();

  final userBillRef = FirebaseDatabase.instance.reference();
  final billRef = FirebaseDatabase.instance.reference().child("Bill");

  Timer _timer;
  bool isFirstTime = true;

  @override
  initState() {
    super.initState();

    userBillRef
        .child("Users-Bills/${widget.provider.uid}")
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        billList.clear();

        var data = snapshot.value;

        data.forEach((key, value) async {
          Bill bill;
          await billRef.child("$key").once().then((DataSnapshot billSnapshot) {
            var billData = billSnapshot.value;

            print(billData);

            bill = new Bill(
                key,
                billData['billNo'],
                billData['describtion'],
                billData['amount'],
                billData['isPaid'],
                DateTime.parse(billData['payDate']));
          }).then((value) {
            billList.add(bill);
          });
        });
      }
    });

    _timer = Timer(Duration(seconds: 3), () {

      setState(() {
        isFirstTime = false;
        billList = billList;
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // payment text
            // Container(
            //   alignment: Alignment.center,
            //   height: 50,
            //   width: size.width,
            //   padding: const EdgeInsets.only(top: 5, bottom: 5),
            //   decoration: BoxDecoration(
            //       color: mainBackGround,
            //       border: Border.all(color: mainBackGround, width: 1.5)),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Text(
            //         "Amount \$${widget.provider.totalPayment.toString()}",
            //         style: TextStyle(
            //             fontSize: 25,
            //             fontWeight: FontWeight.w600,
            //             color: Colors.white.withOpacity(0.9),
            //             letterSpacing: 2),
            //       ),
            //     ],
            //   ),
            // ),

            isFirstTime
                // ? CustomLoader()
                ? Text("")
                : billList.length == 0
                    ? Container(
                        height: 100,
                        margin: EdgeInsets.only(top: 100, left: 150),
                        child: Text(
                          "No Bills yet!",
                          style: TextStyle(fontSize: 24),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Container(
                          height: size.height * 0.9,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: billList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                children: <Widget>[
                                  _billCardInkWell(size, index),
                                  Positioned(
                                      top: 20, left: 10, child: paymentIcon()),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  // payment icon
  Container paymentIcon() {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: mainBackGround),
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: Icon(
        Icons.attach_money_sharp,
        size: 33,
        color: mainBackGround,
      ),
    );
  }

  // main inkWell for the card as child
  InkWell _billCardInkWell(Size size, int index) {
    return InkWell(
      child: Container(
        height: 90.0,
        margin: EdgeInsets.only(left: 40.0, top: 10, right: 5),
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
            _billNoAndAmountRow(size, index),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            _carAndStatusRow(size, index),
          ],
        ),
      ),
    );
  }

  Row _billNoAndAmountRow(Size size, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("Bill# ${billList[index].billNo}",
            style: textCardStyle(mainTitleSize, Colors.black)),
        SizedBox(
          width: size.width / 3,
        ),
        Text('\$${billList[index].amount.toString()}',
            style: textCardStyle(mainTitleSize, Colors.black)),
      ],
    );
  }

  Row _carAndStatusRow(Size size, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(billList[index].payDate.toString().substring(0, 11),
            style: textCardStyle(subTitleSize + 1, Colors.black)),
        SizedBox(
          width: size.width / 3,
        ),
        Text(billList[index].isPaid ? "Paid" : "Not Paid",
            style: statuStyling(subTitleSize + 1, billList[index].isPaid)),
      ],
    );
  }

  // card text styling
  textCardStyle(double fontSize, Color color) {
    return TextStyle(
        fontSize: fontSize, color: color, fontWeight: FontWeight.bold);
  }

  statuStyling(double fontSize, bool status) {
    Color color;
    switch (status) {
      case true:
        color = Colors.green;
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
