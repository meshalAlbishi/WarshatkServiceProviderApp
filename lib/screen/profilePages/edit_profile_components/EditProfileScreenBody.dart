import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';
import 'package:service_provider_app/constant/HeaderCurvedContainer.dart';
import 'package:service_provider_app/screen/profilePages/main_profile_components/ProfileScreenBody.dart';
import 'package:service_provider_app/screen/profilePages/common_payment_components/ProfileTextField.dart';


class EditProfileScreenBody extends StatefulWidget {
  static ServiceProvider provider;

  static TextEditingController phoneController = TextEditingController();

  static TextEditingController emailController = TextEditingController();

  static TextEditingController ibanController = TextEditingController();

  static TextEditingController commercialController = TextEditingController();

  @override
  _EditProfileScreenBodyState createState() => _EditProfileScreenBodyState();
}

class _EditProfileScreenBodyState extends State<EditProfileScreenBody> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
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
            margin: EdgeInsets.only(top: 35.0),
            child: Text(
              ProfileScreenBody.provider.name,
              style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 2),
            ),
          ),
        ],
      ),
    );
  }

  allInfoFields() {
    return Column(
      children: <Widget>[

        // phone filed
        ProfileTextField(
            hintText: ProfileScreenBody.provider.phone,
            topMargin: 200.0,
            isRead: false,
            controller: EditProfileScreenBody.phoneController),

        // email field
        ProfileTextField(
            hintText: ProfileScreenBody.provider.email,
            topMargin: 20.0,
            isRead: false,
            controller: EditProfileScreenBody.emailController),

        // IBAN field
        ProfileTextField(
            hintText: ProfileScreenBody.provider.IBAN,
            topMargin: 20.0,
            isRead: false,
            controller: EditProfileScreenBody.ibanController),

        // commercial field
        ProfileTextField(
            hintText: ProfileScreenBody.provider.commercial.toString(),
            topMargin: 20.0,
            isRead: false,
            controller: EditProfileScreenBody.commercialController),
      ],
    );
  }
}
