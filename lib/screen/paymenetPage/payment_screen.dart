import 'package:flutter/material.dart';
import 'components/PaymentScreenBar.dart';
import 'components/PaymentScreenBody.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';

class PaymentScreen extends StatelessWidget {

  final ServiceProvider provider;

  const PaymentScreen({Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryBackGround,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PaymentScreenBar(provider: provider),
            PaymentScreenBody(provider: provider,),
          ],
        ),
      ),
    );
  }
}


