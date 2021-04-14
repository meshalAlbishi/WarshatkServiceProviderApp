import 'package:flutter/material.dart';
import 'main_profile_components/ProfileScreenBody.dart';
import 'edit_profile_components/EditProfileScreenBar.dart';
import 'edit_profile_components/EditProfileScreenBody.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';


class EditProfileScreen extends StatelessWidget {
  final ServiceProvider provider;

  const EditProfileScreen({Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileScreenBody.provider = provider;

    return Scaffold(
      backgroundColor: secondaryBackGround,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            EditProfileScreenBar(provider: provider,),
            EditProfileScreenBody(),
          ],
        ),
      ),
    );
  }
}
