import 'package:flutter/material.dart';
import 'components/tabsController.dart';
import 'package:service_provider_app/model/ServiceProvider.dart';


class RequestScreen extends StatelessWidget {
  final ServiceProvider provider;

  const RequestScreen({Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabsController(provider: provider,),
    );
  }
}
