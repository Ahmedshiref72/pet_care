import 'package:demo_project/const/colors.dart';
import 'package:demo_project/src/elements/circular_loading.dart';
import 'package:flutter/material.dart';

import 'register_view.dart';

class RegisterContainerView extends StatefulWidget {
  @override
  _CityRegisterContainerViewState createState() =>
      _CityRegisterContainerViewState();
}

class _CityRegisterContainerViewState extends State<RegisterContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  static const Duration animation_duration = Duration(milliseconds: 500);
  @override
  void initState() {
    animationController =
        AnimationController(duration: animation_duration, vsync: this);
    super.initState();
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
        body: Stack(
          children: <Widget>[
            // Container(
            //   color: appColorGreen.withOpacity(0.2),
            //   width: double.infinity,
            //   height: double.maxFinite,
            // ),
            CustomScrollView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              slivers: <Widget>[
                isLoading
                    ? CircularLoadingWidget(height: 500)
                    : RegisterView(
                        animationController: animationController,
                        isLoading: isLoading),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
