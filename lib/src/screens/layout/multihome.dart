import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_project/const/colors.dart';
import 'package:demo_project/localization/language_constants.dart';
import 'package:demo_project/src/blocs/home_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/getCartItem.dart';
import 'package:demo_project/src/models/home_model.dart';
import 'package:demo_project/src/screens/layout/catWiseSeviceList.dart';
import 'package:demo_project/src/screens/layout/new_layouts_product/categoryList.dart';
import 'package:demo_project/src/screens/layout/new_layouts_product/productDetails.dart';
import 'package:demo_project/src/screens/layout/notificationScreen.dart';
import 'package:demo_project/src/screens/layout/searchProduct.dart';
import 'package:demo_project/src/screens/layout/serviceDetail.dart';
import 'package:demo_project/src/screens/layout/serviceList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../../models/serviceDetail_model.dart';
import 'first_container.dart';
import 'new_store_detail/storeDeail2.dart';
import 'offers.dart';

class MultiHome extends StatefulWidget {
  // String? id;
  @override
  _MultiHomeState createState() => _MultiHomeState();
}

class _MultiHomeState extends State<MultiHome> {
  List nearStoreList = [];
  List allProductList = [];
  List nearServiceList = [];
  Position? currentLocation;
  GetCartModel? getCartModel;

  // LocationData? myLocation;

  var distance;

  bool isLoading = false;

  Future getUserCurrentLocation() async {
    await Geolocator.getCurrentPosition().then((position) {
      setState(() {
        currentLocation = position;
      });
    });
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      homeBloc.homeSink();
      // storeBloc.storeSink();
    });
  }

  // nearByStore() {
  //   allProductList = [];
  //   getUserCurrentLocation().then((_) async {
  //     // nearbyBloc.nearbySink();

  //     await HometApi().homeApi().then((nearbyRest) {
  //       for (Store data in nearbyRest.store!) {
  //         if (data.lat != "" && data.lon != "") {
  //           double distanceInKm = calculateDistance(
  //             currentLocation!.latitude,
  //             currentLocation!.longitude,
  //             double.parse(data.lat.toString()),
  //             double.parse(data.lon.toString()),
  //           );
  //           double distanceInMiles = distanceInKm * 0.621371;
  //           if (distanceInMiles <= 20.0) {
  //             setState(() {
  //               nearStoreList.add(data);
  //             });
  //             print('NEAR STORE LIST DATA : $allProductList');
  //           }
  //         }
  //       }
  //     });
  //   });
  // }

  // nearByService() {
  //   nearServiceList = [];
  //   getUserCurrentLocation().then((_) async {
  //     // nearbyBloc.nearbySink();

  //     await HometApi().homeApi().then((nearbyRest) {
  //       for (Services data in nearbyRest.services!) {
  //         if (data.storeLatitude != "" && data.storeLongitude != "") {
  //           double distanceInKm = calculateDistance(
  //             currentLocation!.latitude,
  //             currentLocation!.longitude,
  //             double.parse(data.storeLatitude.toString()),
  //             double.parse(data.storeLongitude.toString()),
  //           );
  //           double distanceInMiles = distanceInKm * 0.621371;
  //           if (distanceInMiles <= 20.0) {
  //             setState(() {
  //               nearServiceList.add(data);
  //             });
  //           }
  //         }
  //       }
  //     });
  //   });
  // }

  // double calculateDistance(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var c = cos;
  //   var a = 0.5 -
  //       c((lat2 - lat1) * p) / 2 +
  //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //   //print(12742 * asin(sqrt(a)));
  //   distance = 12742 * asin(sqrt(a));
  //   return distance;
  // }

  _getCart() async {
    setState(() {
      isLoading = true;
    });

    var uri = Uri.parse('${baseUrl}get_cart_items');
    var request = new http.MultipartRequest("Post", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({'user_id': userID});

    var response = await request.send();
    print(response.statusCode);
    print('response.statusCode');
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        getCartModel = GetCartModel.fromJson(userData);
        isLoading = false;
      });
    }
  }

  _getRequests() async {
    _getCart();
  }

  @override
  initState() {
    // nearByStore();
    // nearByService();
    _getCart();
    homeBloc.homeSink();
    //  storeBloc.storeSink();
    super.initState();
    // _getUserLocation();
  }

  textHomeStyle() {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.color1,
      //    bottomNavigationBar: BottomAppBar(
      //   elevation: 0,
      //   child: Container(
      //     // margin: EdgeInsets.only(bottom: 1),
      //      height: 20,
      //         foregroundDecoration: const BoxDecoration(
      //           gradient: LinearGradient(
      //             colors: [
      //               Colors.white,
      //               Colors.white,
      //             ],
      //             begin: Alignment.bottomCenter,
      //             end: Alignment.center,
      //             stops: [0, 0.10],
      //           ),
      //         ),
      //   ),
      // ),

      // appBar: AppBar(
      //   elevation: 2,
      //   backgroundColor: Colors.white,
      //   leading: Container(),
      //   actions: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(left: 8, right: 190),
      //           child: Image.asset(
      //             'assets/images/logo2.png',
      //             height: 100,
      //             width: 100,
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(right: 5),
      //           child: IconButton(
      //             icon: Icon(
      //               Icons.notifications_none,
      //               color: Colors.black,
      //             ),
      //             onPressed: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => NotificationList()),
      //               );
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        color: appColorBlack,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.grey[400]!,
                              ),

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextField(
                                readOnly: true,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchProduct(),
                                    ),
                                  );
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: translation(context).search,
                                  hintStyle: TextStyle(fontSize: 17),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: w / 6.54,
                          width: w / 6.54,
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Stack(
                            alignment: AlignmentDirectional.topCenter,
                            fit: StackFit.loose,
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 20,
                                  width: w / 6.54,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[700],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              Container(
                                height: w / 7.5,
                                width: w / 7.5,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white30,
                                ),
                                child: Container(
                                  height: w / 8,
                                  width: w / 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     blurRadius: 8,
                                    //     color: Colors.white,
                                    //   ),
                                    // ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(new MaterialPageRoute(
                                              builder: (_) =>
                                                  new NotificationList()))
                                          .then((val) =>
                                              val ? _getRequests() : null);
                                    },
                                    child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      fit: StackFit.loose,
                                      children: [
                                        Image.asset(
                                          'assets/images/Notification.png',
                                          height: 23,
                                          color: Colors.blue[700],
                                        ),
                                        // Icon(
                                        //   Icons.shopping_cart_outlined,
                                        //   color: appColorBlack,
                                        //   size: 25,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              isLoading
                                  ? Padding(
                                      padding:
                                          EdgeInsets.only(top: 13, right: 15),
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(Colors.black),
                                          ),
                                        ),
                                      ),
                                    )
                                  : getCartModel != null
                                      ? Container(
                                          margin: EdgeInsets.only(
                                            top: 8,
                                            left: 9,
                                          ),
                                          padding: EdgeInsets.only(
                                              top: 13, right: 15),
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.amber,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(3),
                                              child: Text(
                                                getCartModel!.totalItems == null
                                                    ? ''
                                                    : getCartModel!.totalItems
                                                        .toString(),
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .merge(
                                                      TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        FirstContainer(
                          16,
                          image: "2",
                          hasStores: true,
                          text: 'Medicine',
                          color: Color(0xff1492E6),
                        ),
                      ],
                    ),
                  ),


                  StreamBuilder<HomeModel>(
                      stream: homeBloc.homeStream,
                      builder: (context, AsyncSnapshot<HomeModel> snapshot) {
                        if (!snapshot.hasData) {
                          return SizedBox(
                            height: h / 1.5,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: appColorBlack,
                              ),
                            ),
                          );
                        }
                        print('DATA>>>>>>>>>');
                        // print(snapshot.data!.banners);
                        // List<String>? banners = snapshot.data!.banners != null
                        //     ? snapshot.data!.banners
                        //     : [];
                        //  List<Object>? category = snapshot.data!.category != null
                        //     ? snapshot.data!.category
                        //     : [];

                        // List<Category>? getAllCategory =
                        //     snapshot.data!.category != null
                        //         ? snapshot.data!.category
                        //         : [];

                        // List<Products>? getAllProduct =
                        //     snapshot.data!.products != null
                        //         ? snapshot.data!.products
                        //         : [];
                        return Column(
                          children: [
                            SizedBox(height: h / 80),
                            Container(

                                child: _poster2(snapshot.data!.banners),
                            decoration: BoxDecoration(
                             /* boxShadow: [
                              BoxShadow(
                                color: Colors.yellow.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 15,
                                offset: Offset(0,.005 ), // changes position of shadow
                              ),
                            ],*/),),
                            SizedBox(height: h / 30),
                            Container(
                             // color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        translation(context).services,
                                        style: textHomeStyle(),
                                      ),
                                      // InkWell(
                                      //   onTap: () {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 CategoryScreen()));
                                      //   },
                                      //   child: Text(
                                      //     "View All",
                                      //     style: TextStyle(
                                      //         fontSize: 12,
                                      //         // fontWeight: FontWeight.bold,
                                      //         color: appColorBlack),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  // Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: GridView.builder(
                                  //       shrinkWrap: true,
                                  //       physics: NeverScrollableScrollPhysics(),
                                  //       primary: false,
                                  //       // padding: EdgeInsets.all(10),
                                  //       gridDelegate:
                                  //           SliverGridDelegateWithFixedCrossAxisCount(
                                  //         crossAxisCount: 3,
                                  //         childAspectRatio: 200 / 220,
                                  //       ),
                                  //       itemCount: snapshot.data!.category!.length < 6
                                  //           ? snapshot.data!.category!.length
                                  //           : 6,
                                  //       itemBuilder: (BuildContext context, int index) {
                                  //         return categoryWidget(
                                  //             snapshot.data!.category![index]);
                                  //       },
                                  //     )),
                                  SizedBox(height: h / 60),

                                  GridView(
                                    padding: EdgeInsets.all(10),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    primary: false,
                                    // padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 10 / 11,
                                      mainAxisSpacing: 14,
                                      crossAxisSpacing: 13,
                                    ),
                                    children: [
                                      AppContainer(
                                        13,
                                        image: "0",
                                        text: translation(context).doctors,
                                        color: Color(0xff62cef9),
                                      ),
                                      AppContainer(
                                        14,
                                        image: "1",
                                        text: translation(context).clinics,
                                        color: Color(0xfffb80ba),
                                      ),
                                      AppContainer(
                                        16,
                                        image: "2",
                                        hasStores: true,
                                        text: translation(context).pharmacy,
                                        color: Color(0xff4AC989),
                                      ),
                                      AppContainer(
                                        19,
                                        image: "5",
                                        hasStores: true,
                                        text: translation(context).pets_Store,
                                        color: Color(0xff1492E6),
                                      ),
                                      AppContainer(
                                        17,
                                        image: "3",
                                        hasStores: true,
                                        text:translation(context).pets_Accessories,
                                        color: Color(0xffA28EEC),
                                      ),
                                      AppContainer(
                                        18,
                                        image: "4",
                                        hasStores: true,
                                        text: translation(context).pets_Food,
                                        color: Color(0xffFF7070),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: h / 30),
                            Container(
                             // color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        translation(context).offers,
                                        style: textHomeStyle(),
                                      ),
                                      /*InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ServiceList(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          translation(context).view_All,
                                          style: TextStyle(
                                              fontSize: 12,
                                              // fontWeight: FontWeight.bold,
                                              color: appColorBlack),
                                        ),
                                      ),*/
                                    ],
                                  ),
                                  // Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: GridView.builder(
                                  //       shrinkWrap: true,
                                  //       physics: NeverScrollableScrollPhysics(),
                                  //       primary: false,
                                  //       // padding: EdgeInsets.all(10),
                                  //       gridDelegate:
                                  //           SliverGridDelegateWithFixedCrossAxisCount(
                                  //         crossAxisCount: 3,
                                  //         childAspectRatio: 200 / 220,
                                  //       ),
                                  //       itemCount: snapshot.data!.category!.length < 6
                                  //           ? snapshot.data!.category!.length
                                  //           : 6,
                                  //       itemBuilder: (BuildContext context, int index) {
                                  //         return categoryWidget(
                                  //             snapshot.data!.category![index]);
                                  //       },
                                  //     )),
                                  SizedBox(height: h / 60),

                                  GridView(
                                    padding: EdgeInsets.all(10),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    primary: false,
                                    // padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 10 / 11,
                                      mainAxisSpacing: 14,
                                      crossAxisSpacing: 13,
                                    ),
                                    children: [

                                      OffersContainer(
                                        16,
                                        image: "1",
                                        hasStores: true,
                                        text: 'Order \nMedicine',
                                        color: Color(0xff1492E6),

                                      ),
                                      OffersContainer(
                                        17,
                                        image: "3",
                                        hasStores: true,
                                        text:'Food & \nAccessories',
                                        color: Color(0xff1492E6),
                                      ),
                                      OffersContainer(
                                        19,
                                        image: "5",
                                        hasStores: true,
                                        text: 'Grooming\n',
                                        color: Color(0xff1492E6),
                                      ),
                                      OffersContainer(
                                        13,
                                        image: "0",
                                        text: "Health \nInsurance",
                                        color: Color(0xff1492E6),
                                      ),



                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(height: 15),
                            // Container(
                            //   color: Colors.white,
                            //   child: Column(
                            //     children: [
                            //       Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //           vertical: 20,
                            //         ),
                            //         child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             Text(
                            //               "Offers",
                            //               style: textHomeStyle(),
                            //             ),
                            //             Text(
                            //               "View All",
                            //               style: TextStyle(
                            //                   fontSize: 12,
                            //                   // fontWeight: FontWeight.bold,
                            //                   color: appColorBlack),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 220,
                            //         child: GridView.builder(
                            //           itemCount: 10,
                            //           scrollDirection: Axis.horizontal,
                            //           gridDelegate:
                            //               SliverGridDelegateWithFixedCrossAxisCount(
                            //             crossAxisCount: 2,
                            //             childAspectRatio: 105 / 165,
                            //             mainAxisSpacing: 5,
                            //             crossAxisSpacing: 5,
                            //           ),
                            //           itemBuilder:
                            //               (BuildContext context, int index) {
                            //             return Container(
                            //               clipBehavior:
                            //                   Clip.antiAliasWithSaveLayer,
                            //               decoration: BoxDecoration(
                            //                 color: Colors.indigo,
                            //                 borderRadius:
                            //                     BorderRadius.circular(10),
                            //               ),
                            //               child: Row(
                            //                 children: [
                            //                   SizedBox(
                            //                     width: 100,
                            //                     child: Column(
                            //                       crossAxisAlignment:
                            //                           CrossAxisAlignment.start,
                            //                       children: [
                            //                         Container(
                            //                           height: 20,
                            //                           width: 80,
                            //                           child: Center(
                            //                             child: Text(
                            //                               '${OfferModel.offers[index].percent}% OFF',
                            //                               style: TextStyle(
                            //                                 color: Colors.white,
                            //                               ),
                            //                             ),
                            //                           ),
                            //                           decoration: BoxDecoration(
                            //                             color: Colors.red,
                            //                             borderRadius:
                            //                                 BorderRadius
                            //                                     .horizontal(
                            //                               right:
                            //                                   Radius.circular(
                            //                                 5,
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ),
                            //                         Spacer(),
                            //                         Padding(
                            //                           padding:
                            //                               const EdgeInsets.only(
                            //                             left: 10,
                            //                             top: 5,
                            //                           ),
                            //                           child: Text(
                            //                             OfferModel.offers[index]
                            //                                 .titleOffer,
                            //                             style: TextStyle(
                            //                               color: Colors.white,
                            //                               fontSize: 15,
                            //                             ),
                            //                           ),
                            //                         ),
                            //                         Spacer(),
                            //                         Center(
                            //                           child: Container(
                            //                             height: 30,
                            //                             width: 90,
                            //                             margin: EdgeInsets.only(
                            //                               bottom: 5,
                            //                             ),
                            //                             child: ElevatedButton(
                            //                               onPressed: () {},
                            //                               style: ElevatedButton
                            //                                   .styleFrom(
                            //                                 padding:
                            //                                     EdgeInsets.zero,
                            //                               ),
                            //                               child: Text(
                            //                                 OfferModel
                            //                                     .offers[index]
                            //                                     .textBtn,
                            //                                 style: TextStyle(
                            //                                   inherit: false,
                            //                                   color:
                            //                                       Colors.white,
                            //                                   fontWeight:
                            //                                       FontWeight
                            //                                           .bold,
                            //                                   fontSize: 14,
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                   Container(
                            //                     width: 65,
                            //                     color: Colors.amber,
                            //                   ),
                            //                 ],
                            //               ),
                            //             );
                            //           },
                            //         ),
                            //       ),
                            //       SizedBox(height: 10.0),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: 15),
                            Container(

                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                         translation(context).top_Doctors,
                                          style: textHomeStyle(),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ServiceList(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            translation(context).view_All,
                                            style: TextStyle(
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                                color: appColorBlack),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                //  SizedBox(height: 3),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Container(
                                      height: 250,
                                      width: MediaQuery.of(context).size.width,
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        primary: false,
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 12,
                                          childAspectRatio: 1.2,
                                        ),
                                        itemCount:
                                            snapshot.data!.services!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final doctor =
                                              snapshot.data!.services![index];
                                          return bulidDoctorContainer(
                                              context,
                                              doctor.id!,
                                              doctor.serviceName!,
                                              doctor.short ?? "aaa",
                                              doctor.serviceImage!,
                                              true);
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                            Consumer(builder: (context, ref, child) {
                              final data = ref.watch(ddd(16));
                              return data.when(
                                  data: (snapshot) {
                                    return Column(
                                      children: [
                                        SizedBox(height: 15),
                                        Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      translation(context).top_Pharmacies,
                                                      style: textHomeStyle(),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    RRRR(
                                                              16,
                                                              translation(context).pharmacy,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        translation(context).view_All,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            // fontWeight: FontWeight.bold,
                                                            color:
                                                                appColorBlack),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 3),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Container(
                                                  height: 250,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: GridView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    primary: false,
                                                    padding: EdgeInsets.zero,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 1,
                                                      mainAxisSpacing: 10,
                                                      crossAxisSpacing: 12,
                                                      childAspectRatio: 1.2,
                                                    ),
                                                    itemCount: snapshot.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      final doctor =
                                                          snapshot[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        NewStoreDetailScreen(
                                                                          doctor
                                                                              .resId,
                                                                          isFromNew:
                                                                              true,
                                                                        )),
                                                          );
                                                        },
                                                        child: IgnorePointer(
                                                          ignoring: true,
                                                          child: bulidDoctorContainer(
                                                              context,
                                                              '0',
                                                              '${doctor.resName}',
                                                              '',
                                                              doctor.resImage!
                                                                  .resImag0!,
                                                              true),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10.0),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  error: (s, sd) => SizedBox(),
                                  loading: () => CircularProgressIndicator());
                            }),
                            SizedBox(height: 15),
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                         translation(context).top_Products,
                                          style: textHomeStyle(),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductCategory(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            translation(context).view_All,
                                            style: TextStyle(
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                                color: appColorBlack),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Container(
                                      height: 250,
                                      width: MediaQuery.of(context).size.width,
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        primary: false,
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 12,
                                          childAspectRatio: 1.2,
                                        ),
                                        itemCount:
                                            snapshot.data?.products?.length ??
                                                0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final doctor =
                                              snapshot.data?.products![index];
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductsDetails(
                                                    productId:
                                                        doctor!.productId,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: IgnorePointer(
                                              ignoring: true,
                                              child: bulidDoctorContainer(
                                                  context,
                                                  '0',
                                                  '${doctor?.productName}',
                                                  '${doctor?.productPrice} \$',
                                                  '${doctor?.productImage}',
                                                  false),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                  SizedBox(
                    height: 15,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        IgnorePointer(
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                // colors: [Colors.transparent, Colors.white],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _poster2(data) {
    Widget carousel = data == null
        ? Center(
            child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(appColorOrange),
          ))
        : Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(),
                child: CarouselSlider(

                  options: CarouselOptions(height: 400, viewportFraction: 1,autoPlayAnimationDuration:Duration(microseconds: 1) ),
                  items: data.map<Widget>((it) {
                    return ClipRRect(
                      borderRadius: new BorderRadius.circular(5.0),
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: it,
                          imageBuilder: (context, imageProvider) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 0),
                            decoration: BoxDecoration(

                              borderRadius: new BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Center(
                            child: Container(
                              height: 50,
                              width: 50,
                              // margin: EdgeInsets.all(70.0),
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    appColorBlack),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );

    return Container(
      height: MediaQuery.of(context).size.height * .22,
      // width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: carousel,
    );
  }

  Widget categoryWidget(Category data) {
    return Container(
      height: MediaQuery.of(context).size.height * 3 / 10,
      child: Padding(
        padding: EdgeInsets.all(2),
        child: InkWell(
          onTap: () {
            print(data.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryWiseServiceList(data.id),
              ),
            );
          },
          child: Card(
            elevation: 1.0,
            shadowColor: Colors.black,
            color: appColorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(08),
            ),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(12),
                    //   color: appColorGreen,
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.network(
                        data.icon!,
                        //fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          );
                        },
                        //color: iconColor,
                      ),
                    ),
                  ),
                  Container(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      data.cName!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: appColorBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(height: 5),
                  // Text(
                  //   cateModel.categories[index].storeCount +
                  //       " Shops",
                  //   style: TextStyle(
                  //       color: appColorWhite,
                  //       fontSize: 12,
                  //       fontFamily: customfont,
                  //       fontWeight: FontWeight.bold),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget productCard(Products data) {
    // String? id = data.id;
    //print("id: "+id);
    return InkWell(
      onTap: () {
        // print("click");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsDetails(
              productId: data.productId,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            // height: MediaQuery.of(context).size.height * 2.6 / 10,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(1.0, 1.0), // shadow direction: bottom right
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          // width: 70,
                          // height: 70,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            //color: Colors.redAccent,
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 90,
                                width: 80,
                                child: Image.network(
                                  data.productImage!,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        data.productName!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "\$" + data.productPrice! + "/h",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                data.proRatings! != ''
                                    ? Row(
                                        children: [
                                          RatingBar.builder(
                                            // minRating: 1,
                                            initialRating:
                                                double.parse(data.proRatings!),
                                            direction: Axis.horizontal,
                                            itemSize: 12,
                                            //ignoreGestures: true,
                                            allowHalfRating: true,
                                            itemCount: 5,

                                            // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                          SizedBox(width: 1),
                                          Container(
                                            margin: EdgeInsets.only(left: 2.0),
                                            height: 20.0,
                                            width: 30.0,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                            ),
                                            child: Center(
                                              child: Text(
                                                data.proRatings!,
                                                style: TextStyle(
                                                    color: appColorWhite,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 5),
                                  child: Text(
                                    data.productDescription!,
                                    maxLines: 2,
                                    // trimLines: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                    // trimMode: TrimMode.Line,

                                    // colorClickableText: appColorYellow,
                                    // lessStyle: TextStyle(
                                    //   fontSize: 12,
                                    //   fontWeight: FontWeight.bold,
                                    //   color: appColorBlack,
                                    //   decoration: TextDecoration.underline,
                                    // ),
                                    // moreStyle: TextStyle(
                                    //   fontSize: 12,
                                    //   fontWeight: FontWeight.bold,
                                    //   color: appColorBlack,
                                    //   decoration: TextDecoration.underline,
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget nearbyServiceCard(Services data) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetailScreen(data.id!),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
        // height: 220.0,
        width: MediaQuery.of(context).size.width * 10 / 10,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Container(
                  height: 130,
                  width: 230,
                  child: Image.network(
                    data.serviceImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text(translation(context).image_Not_Found),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              strokeWidth: 2),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          data.serviceRatings! != ''
                              ? Row(
                                  children: [
                                    RatingBar.builder(
                                      // minRating: 1,
                                      initialRating:
                                          double.parse(data.serviceRatings!),
                                      direction: Axis.horizontal,
                                      itemSize: 12,
                                      //ignoreGestures: true,
                                      allowHalfRating: true,
                                      itemCount: 5,

                                      // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    SizedBox(width: 1),
                                    Container(
                                      margin: EdgeInsets.only(left: 2.0),
                                      height: 20.0,
                                      width: 30.0,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          data.serviceRatings!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            width: 45,
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(left: 10.0),
                          //   height: 20.0,
                          //   width: 35.0,
                          //   // // decoration: BoxDecoration(
                          //   // //   color: Colors.black,
                          //   // //   borderRadius: BorderRadius.circular(6.0),
                          //   // // ),
                          //   // child: Center(
                          //   //     child: Text(
                          //   //   data.serviceRatings!,
                          //   //   style: TextStyle(
                          //   //       color: Colors.white,
                          //   //       fontWeight: FontWeight.bold,
                          //   //       fontSize: 10),
                          //   // )),
                          // ),
                          SizedBox(width: 1),
                          Text(
                            "\$" + data.servicePrice! + "/h",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 10),
                      // RichText(
                      //   text: TextSpan(
                      //     text: "\$" + data.servicePrice!,
                      //     style: TextStyle(
                      //         color: appColorBlack,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 15,
                      //         fontFamily: 'Futura'),
                      //     children: [
                      //       TextSpan(
                      //         text: '/h',
                      //         style: TextStyle(
                      //             color: appColorBlack,
                      //             fontSize: 15,
                      //             fontFamily: 'Futura',
                      //             fontWeight: FontWeight.normal),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 10),
                      // RichText(
                      //   text: TextSpan(
                      //     text: 'By ',
                      //     style: TextStyle(
                      //         color: appColorBlack,
                      //         fontWeight: FontWeight.normal,
                      //         fontSize: 10,
                      //         fontFamily: 'Futura'),
                      //     children: [
                      //       TextSpan(
                      //         text: '${data.storeName!}',
                      //         style: TextStyle(
                      //             color: appColorBlack,
                      //             fontSize: 10,
                      //             fontFamily: 'Futura',
                      //             fontWeight: FontWeight.normal),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // data.serviceRatings! != '0.0' &&
                      //         data.serviceRatings! != ''
                      //     ? Row(
                      //         children: [
                      //           RatingBar.builder(
                      //             initialRating: data.serviceRatings != null
                      //                 ? double.parse(data.serviceRatings!)
                      //                 : 0.0,
                      //             minRating: 0,
                      //             direction: Axis.horizontal,
                      //             allowHalfRating: true,
                      //             itemCount: 5,
                      //             itemSize: 13,
                      //             ignoreGestures: true,
                      //             unratedColor: Colors.grey,
                      //             itemBuilder: (context, _) => Icon(
                      //                 Icons.star,
                      //                 color: appColorOrange),
                      //             onRatingUpdate: (rating) {
                      //               print(rating);
                      //             },
                      //           ),
                      //         ],
                      //       )
                      //     : Container(),
                      // SizedBox(height: 10),
                      // Row(
                      //   children: [
                      //     Icon(Icons.location_on_outlined, size: 15),
                      //     Text(
                      //         calculateDistance(
                      //                 currentLocation!.latitude,
                      //                 currentLocation!.longitude,
                      //                 double.parse(
                      //                     data.storeLatitude!.length > 0
                      //                         ? data.storeLatitude!
                      //                         : '0'),
                      //                 double.parse(
                      //                     data.storeLongitude!.length > 0
                      //                         ? data.storeLongitude!
                      //                         : '0'))
                      //             .toStringAsFixed(0),
                      //         style: TextStyle(fontSize: 12)),
                      //     Text('Km', style: TextStyle(fontSize: 12)),
                      //   ],
                      // ),

                      Flexible(
                        child: new Container(
                          padding: new EdgeInsets.only(right: 0.0, bottom: 0),
                          child: new Text(
                            data.serviceName!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: new TextStyle(
                              fontSize: 13.0,
                              color: new Color(0xFF212121),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 1, vertical: 5),
                        child: Text(
                          data.serviceDescription!,
                          maxLines: 2,
                          // trimLines: 1,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                          // trimMode: TrimMode.Line,

                          // colorClickableText: appColorYellow,
                          // lessStyle: TextStyle(
                          //   fontSize: 12,
                          //   fontWeight: FontWeight.bold,
                          //   color: appColorBlack,
                          //   decoration: TextDecoration.underline,
                          // ),
                          // moreStyle: TextStyle(
                          //   fontSize: 12,
                          //   fontWeight: FontWeight.bold,
                          //   color: appColorBlack,
                          //   decoration: TextDecoration.underline,
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppContainer extends StatelessWidget {
  const AppContainer(this.id,
      {Key? key,
      required this.image,
      this.hasStores = false,
      required this.text,
      required this.color})
      : super(key: key);

  final String text;
  final String image;
  final Color color;
  final int id;
  final hasStores;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (hasStores) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RRRR(
                id,
                text,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryWiseServiceList(
                "$id",
                name: text,
              ),
            ),
          );
        }
      },
      child: Material(
        elevation: 5,
        shadowColor: color,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 5,
             //   offset: Offset(0,.005 ), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("assets/images/gen$image.png"),
                  color: Colors.white,
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget bulidDoctorContainer(BuildContext context, String id, String text1,
    String text2, String image, bool showRate) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetailScreen(id),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
        /*  boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.15),
             spreadRadius: 5,
              blurRadius: 7,
             offset: Offset(0,-5 ), // changes position of shadow
            ),
          ],*/
          borderRadius: BorderRadius.circular(10),
       //   color: Color.fromRGBO(130, 163, 202, 1),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFFE2EBF9),
                backgroundImage: NetworkImage(image,),
                radius: 70,

              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text1,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (text2.isNotEmpty)
                Text(
                  text2,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              if (showRate)
                Rate(
                  icon: Icons.star_border,
                  width: 51,
                  height: 23,
                  text: '4.5',
                  bordercolor: Colors.blue,
                  containercolor: Colors.blue,
                  iconcolor: Colors.white,
                  textcolor: Colors.white,
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

class Rate extends StatelessWidget {
  const Rate(
      {Key? key,
      required this.icon,
      required this.width,
      required this.height,
      required this.text,
      required this.bordercolor,
      required this.containercolor,
      required this.iconcolor,
      required this.textcolor})
      : super(key: key);
  final double width;
  final double height;
  final Color bordercolor;
  final Color containercolor;
  final String text;
  final Color textcolor;
  final IconData icon;
  final Color iconcolor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: containercolor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: bordercolor, width: 3)),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 8),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 12, color: textcolor),
            ),
            SizedBox(
              width: 3,
            ),
            Icon(
              icon,
              color: iconcolor,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}

//
final ddd =
    FutureProvider.autoDispose.family<List<Restaurant2>, int>((ref, id) async {
  final response = await http.post(
    Uri.parse(
      'https://govet.onclick-eg.com/api/get_cat_res',
    ),
    body: {
      'cat_id': '$id',
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    final List<dynamic> data = (json.decode(response.body))['restaurants'];
    return data.map((e) => Restaurant2.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load data');
  }
});

class RRRR extends ConsumerWidget {
  const RRRR(this.id, this.name, {Key? key}) : super(key: key);
  final String name;
  final int id;
  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(ddd(id));
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
        title: Text(
          name,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: data.when(
        data: (data) {
          if (data.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      "assets/images/noproducts.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    translation(context).not_Found_any_Product,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return resCard(context, data[index]);
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }
}
