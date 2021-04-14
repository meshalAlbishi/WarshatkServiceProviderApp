import 'package:flutter/material.dart';
import 'main_profile_components/ProfileScreenBar.dart';
import 'main_profile_components/ProfileScreenBody.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';


class ProfileScreen extends StatelessWidget {
  final ServiceProvider provider;

  const ProfileScreen({Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileScreenBody.provider = provider;

    return Scaffold(
      backgroundColor: secondaryBackGround,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ProfileScreenBar(provider: provider,),
            ProfileScreenBody(),
          ],
        ),
      ),
    );
  }
}
