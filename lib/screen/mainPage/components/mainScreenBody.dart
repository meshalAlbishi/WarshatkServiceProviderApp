import 'MainBody/BottomSideBody.dart';
import 'package:flutter/material.dart';
import 'MainBody/CustomMainPageClipper.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';
import 'package:service_provider_app/screen/mainPage/components/MainBody/topSideBody.dart';

class MainScreenBody extends StatelessWidget {
  final ServiceProvider provider;

  const MainScreenBody({Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomMainPageClipper(),
          child: Container(
            height: 350.0,
            decoration: BoxDecoration(
              color: mainBackGround,
            ),
          ),
        ),
        // top body
        TopSideBody(provider: provider),
        // body
        BottomSideBody(provider: provider),
      ],
    );
  }
}
