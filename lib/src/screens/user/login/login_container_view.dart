import 'package:demo_project/const/colors.dart';
import 'package:demo_project/src/elements/circular_loading.dart';
import 'package:demo_project/src/screens/user/login/login_view.dart';
import 'package:demo_project/src/screens/user/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginContainerView extends StatefulWidget {
  @override
  _LoginContainerViewState createState() => _LoginContainerViewState();
}

class _LoginContainerViewState extends State<LoginContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  static const Duration animation_duration = Duration(milliseconds: 500);
  @override
  void initState() {
    request();
    animationController =
        AnimationController(duration: animation_duration, vsync: this);
    super.initState();
  }

  request() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.notification,
      Permission.camera,
    ].request();
    print(statuses[Permission.location]);
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<bool> _requestPop() {
      animationController!.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    print(
        '............................Build UI Again ............................');
    // userRepo = Provider.of<UserRepository>(context);
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        backgroundColor: MyColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
              /*  Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                      ),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 7,left: 5,right: 5),
                        decoration: BoxDecoration(
                         // color: Colors.blue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ButtonPop(
                          press: () {},
                        ),
                      ),
                    ),
                  ],
                ),*/
                CustomScrollView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  slivers: <Widget>[
                    isLoading
                        ? CircularLoadingWidget(height: 200)
                        : LoginView(
                            animationController: animationController,
                            isLoading: isLoading,
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
