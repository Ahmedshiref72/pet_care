// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:demo_project/src/blocs/profile_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/profile_model.dart';
import 'package:demo_project/src/models/uProfile_model.dart';
import 'package:demo_project/src/screens/chat/fireChatList.dart';
import 'package:demo_project/src/screens/layout/bookings.dart';
import 'package:demo_project/src/screens/layout/changePassword.dart';
import 'package:demo_project/src/screens/layout/edit_Profile.dart';
import 'package:demo_project/src/screens/user/login/login_container_view.dart';
import 'package:demo_project/src/share_preference/preferencesKey.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../app.dart';
import '../../../const/colors.dart';
import '../../../localization/language.dart';
import '../../../localization/language_constants.dart';
import '../user/register/register_view.dart';
import 'google signin/google_sign_in.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  bool? back;

  Profile({this.back});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _username = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _address = TextEditingController();

  //dynamic file = File('');
  final picker = ImagePicker();
  File? selectedImage;
  String? imageUrl;
  ProfileModel? model;
  bool isLoading = false;
  bool isLoad = false;

  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  // Position currentLocation;
  String? _currentAddress;

  @override
  void initState() {
    print(userID); //_getAddressFromLatLng();
    profileBloc.profileSink(userID);
    getUserDataApicall();

    super.initState();
  }

  getUserDataApicall() async {
    setState(() {
      isLoading = true;
    });

    try {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      var map = new Map<String, dynamic>();
      map['user_id'] = userID;
      print("@@@@@@@@@@@@@@@@" + userID);

      final response = await client.post(Uri.parse('${baseUrl}user_data'),
          headers: headers, body: map);

      var dic = json.decode(response.body);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      model = ProfileModel.fromJson(userMap);

      userEmail = model!.user!.email!;
      userMobile = model!.user!.mobile!;
      userName = model!.user!.username!;
      userImage = model!.user!.profilePic!;

      _username.text = model!.user!.username!;
      _mobile.text = model!.user!.mobile!;
      _address.text = model!.user!.address!;
      print("GetUserData>>>>>>");
      print(dic);

      setState(() {
        isLoading = false;
      });
    } on Exception {
      setState(() {
        isLoading = false;
      });
      // Toast.show("No Internet connection", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Fluttertoast.showToast(
          msg: "No Internet connection",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade200,
          textColor: Colors.black,
          fontSize: 13.0);
      throw Exception('No Internet connection');
    }
  }

  // Future getUserCurrentLocation() async {
  //   await Geolocator().getCurrentPosition().then((position) {
  //     if (mounted)
  //       setState(() {
  //         currentLocation = position;
  //       });
  //   });
  // }

  // _getAddressFromLatLng() async {
  //   getUserCurrentLocation().then((_) async {
  //     try {
  //       List<Placemark> p = await geolocator.placemarkFromCoordinates(
  //           currentLocation.latitude, currentLocation.longitude);

  //       Placemark place = p[0];

  //       setState(() {
  //         _currentAddress = "${place.locality}, ${place.country}";
  //         //"${place.name}, ${place.locality},${place.administrativeArea},${place.country}";
  //         print(_currentAddress);
  //       });
  //     } catch (e) {
  //       print(e);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: appColorWhite,
        /* appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            translation(context).profile,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),*/
        body: userID != '0'
            ? isLoading == true
            ? Center(
          child: CircularProgressIndicator(color: appColorBlack),
        )
            : Stack(
          children: [
            _userInfo(),
            isLoad == true ? Center(child: load()) : Container()
          ],
        )
            : Stack(
          children: <Widget>[
            Container(
              width: SizeConfig.screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   'assets/images/guest.png',
                  //   width: SizeConfig.blockSizeHorizontal! * 100,
                  // ),
                  // SizedBox(
                  //   height: SizeConfig.blockSizeVertical! * 3,
                  // ),
                  ElevatedButton(
                    child: Text(translation(context).click_here_to_login),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: appColorBlack,
                      shape: const BeveledRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(5))),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => LoginContainerView(),
                        ),
                            (Route<dynamic> route) => false,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<Language>(
                      iconSize: 30,
                      hint: Text(translation(context).changeLanguage),
                      onChanged: (Language? language) async {
                        if (language != null) {
                          Locale _locale =
                          await setLocale(language.languageCode);
                          AppScreen.setLocale(context, _locale);
                          if (language.languageCode == 'en') {
                            updateBaseUrl(
                                'https://govet.onclick-eg.com/api/');
                          } else {
                            updateBaseUrl(
                                'https://govet.onclick-eg.com/api/');
                          }
                        }
                      },
                      items: Language.languageList()
                          .map<DropdownMenuItem<Language>>(
                            (e) =>
                            DropdownMenuItem<Language>(
                              value: e,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    e.flag,
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                  Text(e.name)
                                ],
                              ),
                            ),
                      )
                          .toList(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _userInfo() {
    return model!.user != null
        ? Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: SafeArea(
                  child: Container(
                    height: 100,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         /* Padding(
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
                          ),*/
                          Text(
                            translation(context).profile,
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
                ),
              ),

              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileEdit()));
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 75,
                        child: Card(
                          elevation: 2,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle,
                                ),
                                child: profilePic(model!.user!),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                translation(context).verify_Profile,
                                style: TextStyle(
                                    color: appColorBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 80,left: 40),
                                child: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: appColorBlack,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FireChatList()));
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 75,
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                translation(context).messages,
                                style: TextStyle(
                                    color: appColorBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 80,left: 40),
                                child: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: appColorBlack,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingList()));
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 75,
                        child: Card(
                          elevation: 2,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                translation(context).past_Bookings,
                                style: TextStyle(
                                    color: appColorBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 80,left: 40),
                                child: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: appColorBlack,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePass()));
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 75,
                        child: Card(
                          elevation: 3,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                translation(context).change_Password,
                                style: TextStyle(
                                    color: appColorBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 80,left: 40),
                                child: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: appColorBlack,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: (() {}),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset:
                              Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 75,
                        child: Card(
                          elevation: 2,
                          child: Row(

                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              DropdownButton<Language>(
                                underline:SizedBox() ,
                                iconSize: 30,
                                iconDisabledColor: appColorBlack,
                                iconEnabledColor: Colors.white,
                                hint: Row(
                                  children: [
                                    Text(
                                      translation(context).changeLanguage,
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                                onChanged: (Language? language) async {
                                  if (language != null) {
                                    Locale _locale = await setLocale(
                                        language.languageCode);
                                    AppScreen.setLocale(context, _locale);
                                    if (language.languageCode == 'en') {
                                      updateBaseUrl(
                                          'https://govet.onclick-eg.com/api/');
                                    } else {
                                      Icon(
                                        Icons.arrow_back,
                                        size: 20,);
                                      updateBaseUrl(
                                          'https://govet.onclick-eg.com/api/');
                                    }
                                  }

                                },
                                items: Language.languageList()
                                    .map<DropdownMenuItem<Language>>(
                                      (e) =>
                                      DropdownMenuItem<Language>(
                                        value: e,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                              e.flag,
                                              style: const TextStyle(
                                                fontSize: 30,),
                                            ),
                                            Text(e.name)
                                          ],
                                        ),
                                      ),
                                )
                                    .toList(),
                              ),
                             Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: DropdownButton<Language>(
                                  underline:SizedBox(
                                  ) ,

                                  iconSize: 30,
                                  iconDisabledColor: appColorBlack,
                                  iconEnabledColor: Colors.white,
                                  hint: IconButton(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      size: 35,)
                                    ,

                                    color: appColorBlack, onPressed: () {

                                  },
                                  ),
                                  onChanged: (Language? language) async {
                                    if (language != null) {
                                      Locale _locale = await setLocale(
                                          language.languageCode);
                                      AppScreen.setLocale(context, _locale);
                                      if (language.languageCode == 'en') {
                                        updateBaseUrl(
                                            'https://govet.onclick-eg.com/api/');
                                      } else {
                                        updateBaseUrl(
                                            'https://govet.onclick-eg.com/api/');
                                      }
                                    }
                                  },
                                  items: Language.languageList()
                                      .map<DropdownMenuItem<Language>>(
                                        (e) =>
                                        DropdownMenuItem<Language>(
                                          value: e,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                e.flag,
                                                style: const TextStyle(
                                                  fontSize: 30,),
                                              ),
                                              Text(e.name)
                                            ],
                                          ),
                                        ),
                                  )
                                      .toList(),
                                ),
                              ),
                              /*Padding(
                                padding: const EdgeInsets.only(
                                    right: 20),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      size: 35,)
                                    ,

                                    color: appColorBlack, onPressed: () {

                                },
                                ),
                              )*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          userID = '';

                          userEmail = '';
                          userMobile = '';
                          likedProduct = [];
                          likedService = [];
                        });
                        signOutGoogle();
                        //signOutFacebook();
                        preferences!.remove('guest user');
                        preferences!
                            .remove(
                            SharedPreferencesKey.LOGGED_IN_USERRDATA)
                            .then((_) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginContainerView(),
                            ),
                                (Route<dynamic> route) => false,
                          );
                        });
                        // Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 75,
                        child: Card(
                          elevation: 2,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                translation(context).logout,
                                style: TextStyle(
                                    color: appColorBlack,
                                    fontWeight: FontWeight.bold),
                              ),Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 80,left: 40),
                                child: Icon(
                                  Icons.logout,
                                  color: appColorBlack,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 5,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 55, right: 55),
              //   child: InkWell(
              //     onTap: () {
              //       updateAPICall();
              //     },
              //     child: SizedBox(
              //         height: 50,
              //         width: double.infinity,
              //         child: Container(
              //           decoration: BoxDecoration(
              //               color: appColorBlack,
              //               // gradient: new LinearGradient(
              //               //     colors: [
              //               //       const Color(0xFF4b6b92),
              //               //       const Color(0xFF619aa5),
              //               //     ],
              //               //     begin: const FractionalOffset(0.0, 0.0),
              //               //     end: const FractionalOffset(1.0, 0.0),
              //               //     stops: [0.0, 1.0],
              //               //     tileMode: TileMode.clamp),
              //               border:
              //                   Border.all(color: Colors.grey.shade400),
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(15))),
              //           height: 50.0,
              //           // ignore: deprecated_member_use
              //           child: Center(
              //             child: Stack(
              //               children: [
              //                 Align(
              //                   alignment: Alignment.center,
              //                   child: Text(
              //                     "UPDATE",
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                         color: appColorWhite,
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 15),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         )),
              //   ),
              // ),


            ],
          ),
        ),
      ],
    )
        : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              translation(context).no_data_found,
              style:
              TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 6.5),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 3,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal! * 60,
              height: SizeConfig.blockSizeVertical! * 7,
              child: CupertinoButton(
                onPressed: () =>
                {
                  // Navigator.push(
                  //   context,
                  //   CupertinoPageRoute(
                  //     builder: (context) => Login(),
                  //   ),
                  // )
                },
                color: Color(0xFF1E3C72),
                borderRadius: new BorderRadius.circular(30.0),
                child: new Text(
                  translation(context).login_Now,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.blockSizeHorizontal! * 3.5),
                ),
              ),
            ),
          ],
        ));
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(translation(context).logout),
          content:
          new Text(translation(context).are_you_sure_you_want_to_log_out),
          actions: <Widget>[
            new TextButton(
              child: new Text(translation(context).cancel),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            new TextButton(
              child: new Text(translation(context).ok),
              onPressed: () {
                setState(() {
                  userID = '';

                  userEmail = '';
                  userMobile = '';
                  likedProduct = [];
                  likedService = [];
                });
                signOutGoogle();
                //signOutFacebook();
                preferences!.remove('guest user');
                preferences!
                    .remove(SharedPreferencesKey.LOGGED_IN_USERRDATA)
                    .then((_) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => LoginContainerView(),
                    ),
                        (Route<dynamic> route) => false,
                  );
                });
                // Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  Widget profilePic(User user) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        userImg(user),
//     editIconForPhoto(),
      ],
    );
  }

  Widget userImg(User user) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () {
          // openImageFromCamOrGallary(context);
        },
        child: Container(
          height: 150,
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: selectedImage == null
                ? user.profilePic != null
                ? Image.network(
              user.profilePic!,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext? context, Object? exception,
                  StackTrace? stackTrace) {
                return Icon(Icons.person, size: 100);
              },
            )
                : Icon(Icons.person, size: 100)
                : Image.file(selectedImage!, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  // Widget editIconForPhoto() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Colors.white,
  //     ),
  //     padding: EdgeInsets.all(5),
  //     child: Container(
  //         child: InkWell(
  //       onTap: () {
  //         openImageFromCamOrGallary(context);
  //       },
  //       child: Image.asset('assets/images/shield.jpg', height: 25),
  //     )),
  //   );
  // }

  // void containerForSheet<T>({BuildContext? context, Widget? child}) {
  //   showCupertinoModalPopup<T>(
  //     context: context!,
  //     builder: (BuildContext context) => child!,
  //   ).then<void>((T) {});
  // }

  // openImageFromCamOrGallary(BuildContext context) {
  //   containerForSheet<String>(
  //     context: context,
  //     child: CupertinoActionSheet(
  //       actions: <Widget>[
  //         CupertinoActionSheetAction(
  //           child: Text(
  //             "Camera",
  //             style: TextStyle(color: Colors.black, fontSize: 15),
  //           ),
  //           onPressed: () {
  //             getImageFromCamera();
  //             Navigator.of(context, rootNavigator: true).pop("Discard");
  //           },
  //         ),
  //         CupertinoActionSheetAction(
  //           child: Text(
  //             "Photo & Video Library",
  //             style: TextStyle(color: Colors.black, fontSize: 15),
  //           ),
  //           onPressed: () {
  //             getImageFromGallery();
  //             Navigator.of(context, rootNavigator: true).pop("Discard");
  //           },
  //         ),
  //       ],
  //       cancelButton: CupertinoActionSheetAction(
  //         child: Text(
  //           "Cancel",
  //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  //         ),
  //         isDefaultAction: true,
  //         onPressed: () {
  //           // Navigator.pop(context, 'Cancel');
  //           Navigator.of(context, rootNavigator: true).pop("Discard");
  //         },
  //       ),
  //     ),
  //   );
  // }

  // Future getImageFromCamera() async {
  //   // ignore: deprecated_member_use
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);
  //   setState(() {
  //     if (pickedFile != null) {
  //       selectedImage = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  // Future getImageFromGallery() async {
  //   // ignore: deprecated_member_use
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       selectedImage = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  updateAPICall() async {
    closeKeyboard();
    UprofileModel editProfileModal;

    setState(() {
      isLoad = true;
    });

    var uri = Uri.parse('${baseUrl}user_edit');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields['email'] = model!.user!.email.toString();
    request.fields['username'] = _username.text;
    request.fields['mobile'] = _mobile.text;
    request.fields['address'] = _address.text;
    request.fields['city'] = model!.user!.city.toString();
    request.fields['country'] = model!.user!.country.toString();
    request.fields['id'] = userID;

    if (selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'profile_pic', selectedImage!.path));
    }
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    editProfileModal = UprofileModel.fromJson(userData);

    if (editProfileModal.responseCode == "1") {
      setState(() {
        isLoad = false;
      });

      Flushbar(
        title: "Success",
        message: editProfileModal.message,
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.done,
          color: appColorOrange,
          size: 35,
        ),
      )
        ..show(context);
    } else {
      setState(() {
        isLoad = false;
      });
      Flushbar(
        title: "Error",
        message: editProfileModal.message,
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
      )
        ..show(context);
    }
  }
}

