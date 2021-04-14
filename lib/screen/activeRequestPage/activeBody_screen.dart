import 'components/ActiveBody.dart';
import 'components/ActiveBodyBar.dart';
import 'package:flutter/material.dart';
import 'package:service_provider_app/model/Request.dart';
import 'package:service_provider_app/constant/ForMap.dart';
import 'package:service_provider_app/constant/constants.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';

class ActiveBodyScreen extends StatelessWidget {
  final ServiceProvider provider;
  final Request request;

  ActiveBodyScreen({Key key, this.provider, this.request}) : super(key: key);

  // static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      child: Scaffold(
        appBar: ActiveBodyBar().build(context, request, provider),
        backgroundColor: secondaryBackGround,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              ActiveBody(request: request, provider: provider),
              Positioned(
                top: size.height * 0.77,
                right: size.width * 0.06,
                child: FloatingActionButton(
                  heroTag: null,
                  elevation: 5.0,
                  backgroundColor: Colors.blue,
                  // backgroundColor: Color(0xFF3d3f3b),
                  child: Icon(
                    Icons.directions,
                    size: 30.0,
                  ),
                  onPressed: () {
                    MapUtils.openMap(request.latitude, request.longitude);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
