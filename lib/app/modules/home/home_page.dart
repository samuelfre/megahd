import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/shared/constants.dart';
import 'package:rate_app_dialog/rate_app_dialog.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    RateAppDialog(
            context: context,
            afterStarRedirect: true,
            customDialogIOS: true,
            minimeRequestToShow: minValueToShow,
            minimeRateIsGood: 4)
        .requestRate();
    Timer.periodic(Duration(seconds: 5), (timer) {
      timer.cancel();
      Modular.to.pushNamedAndRemoveUntil('/feed', ModalRoute.withName('/feed'));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
