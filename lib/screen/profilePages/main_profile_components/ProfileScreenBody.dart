import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';
import 'package:service_provider_app/constant/HeaderCurvedContainer.dart';
import 'package:service_provider_app/screen/profilePages/common_payment_components/ProfileTextField.dart';

class ProfileScreenBody extends StatefulWidget {
  static ServiceProvider provider;

  @override
  _ProfileScreenBodyState createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _ibanController = TextEditingController();
  TextEditingController _commercialController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          allInfoFields(),

          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
            ),
            painter: HeaderCurvedContainer(),
          ),

          // profile text
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 15.0),
            // padding: const EdgeInsets.only(top: 5),
            child: Text(
              ProfileScreenBody.provider.name,
              style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 2),
            ),
          ),

          _numRequestsUI(),
        ],
      ),
    );
  }

  // create number of Requests ui ----------------------------
  Widget _numRequestsUI() {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 70),
        child: _requestColumn());
  }

  Widget _requestColumn() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text("Requests",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70.withOpacity(0.9),
                  letterSpacing: 2)),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            ProfileScreenBody.provider.numRequests.toString(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                letterSpacing: 2),
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------

  allInfoFields() {
    return Column(
      children: <Widget>[
        // phone filed
        ProfileTextField(
            hintText: ProfileScreenBody.provider.phone,
            topMargin: 170.0,
            isRead: true,
            controller: _phoneController),
        // email field
        ProfileTextField(
            hintText: ProfileScreenBody.provider.email,
            topMargin: 20.0,
            isRead: true,
            controller: _emailController),
        // IBAN field
        ProfileTextField(
            hintText: ProfileScreenBody.provider.IBAN,
            topMargin: 20.0,
            isRead: true,
            controller: _ibanController),
        // commercial field
        ProfileTextField(
            hintText: ProfileScreenBody.provider.commercial.toString(),
            topMargin: 20.0,
            isRead: true,
            controller: _commercialController),
      ],
    );
  }
}
