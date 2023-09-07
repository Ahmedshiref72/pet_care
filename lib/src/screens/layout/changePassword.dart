import 'package:demo_project/const/colors.dart';
import 'package:demo_project/src/blocs/changepass_bloc.dart';
import 'package:demo_project/src/elements/ps_button_widgets.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/screens/layout/serviceList.dart';
import 'package:demo_project/src/screens/user/register/register_view.dart';
import 'package:demo_project/src/strings.dart/string.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../localization/language_constants.dart';

class ChangePass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ChangePass> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _npassController = TextEditingController();
  final TextEditingController _cpassController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: MyColors.background,

      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(1.0, 1.0), // shadow direction: bottom right
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.only(bottom: 7),
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(-1, .005), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ButtonPop(
                              press: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*.1,
                        ),
                    Text(
                      translation(context).change_Password,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Stack(
              children: [


                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Text(
                              'Enter your new password',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: [
                            _passTextfield(context),
                            SizedBox(
                              height: 20,
                            ),
                            _npassTextfield(context),
                            SizedBox(
                              height: 20,
                            ),
                            _cpassTextfield(context),
                            SizedBox(
                              height: 20,
                            ),
                            _loginButton(context),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                isLoading == true
                    ? Center(
                        child: loader(context),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return PSButtonWidget(
      titleText: 'Change',
      onPressed: () async {
        if (_passController.text.isNotEmpty &&
            _npassController.text.isNotEmpty &&
            _cpassController.text.isNotEmpty) {
          if (_npassController.text == _cpassController.text) {
            _apiCall();
          } else {
            // Toast.show("Password do not match", context,
            //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            Fluttertoast.showToast(
                msg: "Password do not match",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade200,
                textColor: Colors.black,
                fontSize: 13.0);
          }
        } else {
          // Toast.show("Missing Fields", context,
          //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          Fluttertoast.showToast(
              msg: "Missing Fields",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey.shade200,
              textColor: Colors.black,
              fontSize: 13.0);
        }
      },
      hasShadow: true,
      width: double.infinity,
      colorData: null,
      gradient: null,
    );
  }

  _apiCall() async {
    setState(() {
      isLoading = true;
    });

    changePassBloc
        .changePassSink(userID, _passController.text, _npassController.text,
            _cpassController.text)
        .then((userData) {
      if (userData.responseCode == Strings.responseSuccess) {
        Fluttertoast.showToast(
            msg: userData.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade200,
            textColor: Colors.black,
            fontSize: 13.0);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: userData.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade200,
            textColor: Colors.black,
            fontSize: 13.0);
      }
    });

    // if (changePassModal.responseCode == "1") {
    //   Toast.show(changePassModal.message, context,
    //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    //   Navigator.pop(context);
    // } else {
    //   Toast.show(changePassModal.message.toString(), context,
    //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    // }

    setState(() {
      isLoading = false;
    });
  }

  Widget _passTextfield(BuildContext context) {
    return CustomtextField(
      controller: _passController,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      hintText: 'Current Password',
      prefixIcon:
          Container(margin: EdgeInsets.all(10.0), child: Icon(Icons.lock)),
    );
  }

  Widget _npassTextfield(BuildContext context) {
    return CustomtextField(
      controller: _npassController,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      hintText: 'New Password',
      prefixIcon:
          Container(margin: EdgeInsets.all(10.0), child: Icon(Icons.lock)),
    );
  }

  Widget _cpassTextfield(BuildContext context) {
    return CustomtextField(
      controller: _cpassController,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      hintText: 'Confirm Password',
      prefixIcon:
          Container(margin: EdgeInsets.all(10.0), child: Icon(Icons.lock)),
    );
  }
}
