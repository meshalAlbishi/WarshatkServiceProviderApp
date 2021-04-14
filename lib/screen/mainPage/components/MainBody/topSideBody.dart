import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';

class TopSideBody extends StatelessWidget {
  final ServiceProvider provider;

  const TopSideBody({Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // left part
          _leftSide(),

          // right part
          _rightSide(),
        ],
      ),
    );
  }

  TextStyle _topBodyStyle(double fontSize) {
    return TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
  }

  Column _leftSide() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Earnings: ${provider.totalPayment}",
          style: _topBodyStyle(24),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "Your Rating: ${provider.rating}",
          style: _topBodyStyle(20),
        )
      ],
    );
  }

  Container _rightSide() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: 35,
      child: LiteRollingSwitch(
        value: false,
        // ------------------
        textOff: 'inactive',
        colorOff: Colors.blueGrey,
        iconOff: Icons.remove_circle_outline,
        // ------------------
        textOn: 'active',
        colorOn: Colors.greenAccent.shade700,
        iconOn: Icons.power_settings_new,
        // ------------------
        textSize: 18.0,
        onChanged: (bool state) {
          provider.appActivity =  (state ? "active" : "inactive");
          String newAppActivity = (state ? "active" : "inactive");

          provider.providerRef.update({'appActivity': newAppActivity});
        },
      ),
    );
  }
}
