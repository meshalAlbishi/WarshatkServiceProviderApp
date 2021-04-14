import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';
import 'package:service_provider_app/screen/profilePages/main_profile_screen.dart';
import 'package:service_provider_app/screen/profilePages/edit_profile_components/EditProfileScreenBody.dart';


class EditProfileScreenBar extends StatelessWidget {
  final ServiceProvider provider;

  EditProfileScreenBar({Key key, this.provider}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: mainBackGround,
        border: Border.all(color: mainBackGround),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20.0, right: 10.0, left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // back to menu icon
            IconButton(
                icon: Icon(
                  Icons.cancel,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed: () {
                  _backToMainScreen(context);
                }),

            Text(
              "Edit Profile",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),

            // edit profile icon
            IconButton(
                icon: Icon(
                  Icons.save,
                  size: 32,
                  color: Colors.white,
                ),
                onPressed: () {
                  _saveData(context);
                })
          ],
        ),
      ),
    );
  }

  _saveData(BuildContext context) {
    if (!_validateFields(context)) {
      return;
    }

    _updateProvider(context);
  }

  _backToMainScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileScreen(
                provider: provider,
              )),
    );
  }

  _validateFields(BuildContext context) {
    // check empty or not
    if (EditProfileScreenBody.phoneController.text.isEmpty ||
        EditProfileScreenBody.emailController.text.isEmpty ||
        EditProfileScreenBody.ibanController.text.isEmpty ||
        EditProfileScreenBody.commercialController.text.isEmpty) {
      showSnackBar("Fields Cant be empty", context, mainBackGround);
      return false;
    }

    // check phone
    if (EditProfileScreenBody.phoneController.text.length != 10) {
      showSnackBar("Check Phone Number", context, mainBackGround);
      return false;
    }

    // check iban
    if (EditProfileScreenBody.ibanController.text.length != 24) {
      showSnackBar("Check IBAN", context, mainBackGround);
      return false;
    }

    return true;
  }

  void _updateProvider(BuildContext context) {
   bool isUpdate =  provider.updateProvider(
        EditProfileScreenBody.phoneController.text,
        EditProfileScreenBody.emailController.text,
        EditProfileScreenBody.ibanController.text,
        EditProfileScreenBody.commercialController.text);

   if(isUpdate){
     FirebaseAuth.instance.currentUser.updateEmail(provider.email);
     showSnackBar("Updated Successfully ", context, Colors.greenAccent);

     Navigator.pushReplacement(
       context,
       MaterialPageRoute(
           builder: (context) => ProfileScreen(
             provider: provider,
           )),
     );

   }else{
     showSnackBar("Something Went Wrong", context, mainBackGround);
   }

  }

}
