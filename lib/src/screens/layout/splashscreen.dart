import 'dart:async';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/screens/layout/welcome.dart';
import 'package:demo_project/src/screens/user/login/login_container_view.dart';
import 'package:flutter/material.dart';

import '../../share_preference/preferencesKey.dart';
import 'newTabbar.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController? animationController;
  Animation<double>? animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    String? data = preferences?.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
    // Navigator.of(context).pushReplacementNamed(App_Screen);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        if (data == null) {
          if (preferences!.containsKey("guest user")) {
            print('0');
            return LoginContainerView();

          } else {
            print('1');
            return WelcomeScreen();
          }
        } else {
          print('2');
          return TabbarScreen();
        }


      }),
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(
        parent: animationController!, curve: Curves.easeOut);

    animation!.addListener(() => this.setState(() {}));
    animationController!.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 100,
      color: appColorWhite,
      child: Center(
        child: Image.asset(
          'assets/images/Logo2.png',
          height: 80,
          //fit: BoxFit.contain,
          // width: SizeConfig.blockSizeHorizontal * 50,
        ),
      ),
    );
  }
}
