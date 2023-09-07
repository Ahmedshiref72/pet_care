// ignore_for_file: unused_field

import 'dart:convert';

import 'package:demo_project/localization/language_constants.dart';
import 'package:demo_project/src/blocs/validation.dart';
import 'package:demo_project/src/elements/error_dialog.dart';
import 'package:demo_project/src/elements/ps_button_widgets.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/screens/user/login/login_container_view.dart';
import 'package:demo_project/src/screens/user/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotView extends StatefulWidget {
  final AnimationController? animationController;

  //final bool? isLoading;
  ForgotView({
    Key? key,
    this.animationController,

    //this.isLoading,
  }) : super(key: key);

  @override
  _ForgotViewState createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  static const Duration animation_duration = Duration(milliseconds: 500);

  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    animationController =
        AnimationController(duration: animation_duration, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    // nameController.dispose();
    // emailController.dispose();
    // passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(
            parent: animationController!,
            curve: const Interval(0.5 * 1, 1.0, curve: Curves.fastOutSlowIn)));

    animationController!.forward();

    return SliverToBoxAdapter(
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: AnimatedBuilder(
              animation: animationController!,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Please enter your email address. You will receive a link to create a new password via email',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50),
                  _TextFieldWidget(
                    emailText: _emailController,
                  ),

                  // _TermsAndConCheckbox(
                  //   nameTextEditingController: _unameController,
                  //   emailTextEditingController: _emailController,
                  //   passwordTextEditingController: _passwordController,
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  _SignInButtonWidget(
                    emailTextEditingController: _emailController,
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              builder: (BuildContext? context, Widget? child) {
                return FadeTransition(
                    opacity: animation,
                    child: Transform(
                        transform: Matrix4.translationValues(
                            0.0, 100 * (1.0 - animation.value), 0.0),
                        child: child));
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class _TermsAndConCheckbox extends StatefulWidget {
//   const _TermsAndConCheckbox({
//     required this.nameTextEditingController,
//     required this.emailTextEditingController,
//     required this.passwordTextEditingController,
//   });

//   final TextEditingController nameTextEditingController,
//       emailTextEditingController,
//       passwordTextEditingController;
//   @override
//   __TermsAndConCheckboxState createState() => __TermsAndConCheckboxState();
// }

// class __TermsAndConCheckboxState extends State<_TermsAndConCheckbox> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         const SizedBox(
//           width: PsDimens.space20,
//         ),
//         Checkbox(
//           value: this.showvalue,
//           onChanged: () {

//           },
//         ),
//         Expanded(
//           child: InkWell(
//             child: Text(
//               Utils.getString(context, 'login__agree_privacy'),
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//             onTap: () {
//               setState(() {
//                 updateCheckBox(
//                     widget.provider.isCheckBoxSelect,
//                     context,
//                     widget.provider,
//                     widget.nameTextEditingController,
//                     widget.emailTextEditingController,
//                     widget.passwordTextEditingController);
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// void updateCheckBox(
//     bool isCheckBoxSelect,
//     BuildContext context,
//     TextEditingController nameTextEditingController,
//     TextEditingController emailTextEditingController,
//     TextEditingController passwordTextEditingController) {
//   if (isCheckBoxSelect) {
//     provider.isCheckBoxSelect = false;
//   } else {
//     provider.isCheckBoxSelect = true;
//     //it is for holder
//     provider.psValueHolder.userNameToVerify = nameTextEditingController.text;
//     provider.psValueHolder.userEmailToVerify = emailTextEditingController.text;
//     provider.psValueHolder.userPasswordToVerify =
//         passwordTextEditingController.text;
//     Navigator.pushNamed(context, RoutePaths.privacyPolicy, arguments: 1);
//   }
// }

class _TextWidget extends StatefulWidget {
  // ignore: unused_element
  const _TextWidget({this.goToLoginSelected});
  final Function? goToLoginSelected;
  @override
  __TextWidgetState createState() => __TextWidgetState();
}

class __TextWidgetState extends State<_TextWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          child: Ink(
            // color: appColorBlack,
            child: Text(
              translation(context).remember_Password_Login,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: appColorBlack),
            ),
          ),
        ),
        onTap: () {
          // if (widget.goToLoginSelected != null) {
          //   widget.goToLoginSelected!();
          // } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginContainerView()));
        }
        // },
        );
  }
}

class _TextFieldWidget extends StatefulWidget {
  const _TextFieldWidget({
    required this.emailText,
  });

  final TextEditingController emailText;
  @override
  __TextFieldWidgetState createState() => __TextFieldWidgetState();
}

class __TextFieldWidgetState extends State<_TextFieldWidget> {
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder<String>(
          stream: validationBloc.email,
          builder: (context, AsyncSnapshot<String> snapshot) {
            return TextField(
              controller: widget.emailText,
              onChanged: validationBloc.changeEmail,
              focusNode: _emailFocus,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).requestFocus(_passwordFocus);
              },
              decoration: InputDecoration(
                errorText:
                    snapshot.error != null ? snapshot.error.toString() : '',
                errorStyle: snapshot.error == null
                    ? TextStyle(height: 0)
                    : TextStyle(height: 1),
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.black45),
                fillColor: Colors.white,
                filled: true,
                label: Text(
                  translation(context).emailAddress,
                  style: textStyle(),
                ),
                border: border(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 25,
                  horizontal: 15,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SignInButtonWidget extends StatefulWidget {
  final TextEditingController emailTextEditingController;

  _SignInButtonWidget({
    required this.emailTextEditingController,
  });

  @override
  __SignInButtonWidgetState createState() => __SignInButtonWidgetState();
}

dynamic callWarningDialog(BuildContext context, String text) {
  showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return ErrorDialog(
          message: text,
        );
      });
}

class __SignInButtonWidgetState extends State<_SignInButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? loader(context)
          : PSButtonWidget(
              hasShadow: true,
              width: double.infinity,
              titleText: translation(context).continue0,
              onPressed: () {
                print(
                    '............................Button Pressed ............................');
                // setState(() {
                //   isLoading = true;
                // });

                if (widget.emailTextEditingController.text.isEmpty) {
                  showDialog<dynamic>(
                      context: context,
                      builder: (BuildContext context) {
                        return ErrorDialog(
                          message: translation(context).enterEmail,
                        );
                      });
                } else {
                  if (RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(
                          widget.emailTextEditingController.text.trim())) {
                    _apiCall(context);
                    // await widget.provider.signUpWithEmailId(
                    //     context,
                    //     widget.onRegisterSelected,
                    //     widget.nameTextEditingController.text,
                    //     widget.emailTextEditingController.text.trim(),
                    //     widget.passwordTextEditingController.text);
                  } else {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ErrorDialog(
                            message: translation(context).enterValidEmail,
                          );
                        });
                  }
                }
              },
              colorData: null,
              gradient: null,
            ),
    );
  }

  bool isLoading = false;

  _apiCall(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    if (regex.hasMatch(widget.emailTextEditingController.text)) {
      try {
        final response =
            await client.post(Uri.parse('${baseUrl}forgot_pass'), body: {
          "email": widget.emailTextEditingController.text.trim(),
        });

        if (response.statusCode == 200) {
          Map<String, dynamic> dic = json.decode(response.body);
          if (dic['status'] == 1) {
            setState(() {
              isLoading = false;
            });
            // Fluttertoast.showToast(
            //     "New Password has been sent to your email.", context,
            //     duration: Toast.LENGTH_LONG,
            //     gravity: Toast.BOTTOM,
            //   );
            Fluttertoast.showToast(
                msg: translation(context).new_Password_has_been_sent_to_your_email,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 13.0);
            Navigator.pop(context);
          } else {
            // Toast.show("Enter valid E-mail", context,
            //     duration: Toast.LENGTH_SHORT,
            //     gravity: Toast.BOTTOM
            //     );
            Fluttertoast.showToast(
                msg: translation(context).enterValidEmail,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 13.0);
          }
          setState(() {
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });

          // Toast.show("Some error occurs", context,
          //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          Fluttertoast.showToast(
              msg: translation(context).some_error_occurs,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 13.0);
        }
      } on Exception {
        setState(() {
          isLoading = false;
        });

        // Toast.show("Email incorrect or No Internet connection", context,
        //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        Fluttertoast.showToast(
            msg: translation(context).email_incorrect_or_No_Internet_connection,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 13.0);

        throw Exception(translation(context).email_incorrect_or_No_Internet_connection);
      }
    } else {
      setState(() {
        isLoading = false;
      });

      // Toast.show("Enter valid E-mail", context,
      //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      Fluttertoast.showToast(
          msg: translation(context).enterValidEmail,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 13.0);
    }
  }
}
