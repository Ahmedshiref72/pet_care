import 'package:demo_project/localization/language_constants.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/screens/user/login/login_container_view.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appColorWhite,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                    ),
                    Image.asset(
                      'assets/images/Logo2.png',
                      height: 50,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Text(appName,
                    //     style: TextStyle(
                    //         color: appColorWhite,
                    //         fontSize: 25,
                    //         fontWeight: FontWeight.bold,
                    // //         fontStyle: FontStyle.italic)),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Text(translation(context).your_on_demand_service_App,
                        style: TextStyle(
                          color: appColorBlack,
                          fontSize: 14,
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Image.asset(
                        'assets/images/splash.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                        translation(context).about_Us,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: appColorBlack,
                          fontSize: 15,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 4,
                      width: 50,
                      decoration: BoxDecoration(
                          color: appColorBlack,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Container(
                    height: 50.0,
                    // ignore: deprecated_member_use
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginContainerView()),
                        );
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(10),
                        backgroundColor:
                            MaterialStateProperty.all(appColorBlack),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Text(
                        translation(context).get_STARTED,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: appColorWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   height: 4,
            //   width: 150,
            //   decoration: BoxDecoration(
            //       color: appColorWhite,
            //       borderRadius: BorderRadius.all(Radius.circular(30))),
            // ),
            SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
