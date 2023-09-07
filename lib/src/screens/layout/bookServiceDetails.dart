// ignore_for_file: unused_field, unused_element

import 'dart:convert';
import 'package:demo_project/localization/language_constants.dart';
import 'package:http/http.dart' as http;
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/serviceDetail_model.dart';
import 'package:demo_project/src/screens/layout/checkoutService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart'
    as ss;
import 'package:google_maps_flutter/google_maps_flutter.dart' as qq;

// ignore: must_be_immutable
class BookServiceDetails extends StatefulWidget {
  String pickedLocation;
  String notes;
  String bookingdate;
  String timeValue;
  String price;
  String resid;
  BookServiceDetails(this.resid, this.pickedLocation, this.notes,
      this.bookingdate, this.timeValue, this.price);

  @override
  _BookServiceDetailsState createState() => _BookServiceDetailsState(
      this.resid,
      this.pickedLocation,
      this.notes,
      this.bookingdate,
      this.timeValue,
      this.price);
}

class _BookServiceDetailsState extends State<BookServiceDetails> {
  String _timeValue = '';
  String _pickedLocation = '';
  bool seven = false;
  bool eight = false;
  bool nine = false;
  bool ten = false;
  bool eleven = false;
  bool twelve = false;
  bool one = false;
  bool two = false;
  bool three = false;
  bool six = false;
  bool seven1 = false;
  bool eight1 = false;

  bool isLoading = false;

  ServiceDetailModel? restaurants;

  _BookServiceDetailsState(String resid, String pickedLocation, String notes,
      String bookingdate, String timeValue, String price);

  @override
  void initState() {
    super.initState();
    _getProductDetails();
  }

  _getProductDetails() async {
    var uri = Uri.parse('${baseUrl}get_service_details');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields['service_id'] = widget.resid;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        restaurants = ServiceDetailModel.fromJson(userData);
        print(restaurants);
        // totalPrice = restaurants.product.productPrice;
      });
    }

    print(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
         translation(context).booking_Confirmation,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
            // height: //set your height here
            width: double.maxFinite, //set your width here
            decoration: BoxDecoration(
                // color: Colors.grey.shade200,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.0))),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print(restaurants);
                        print(widget.price);
                        print(widget.pickedLocation);
                        print(widget.bookingdate);
                        print(widget.timeValue);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckOutService(
                                      restaurants: restaurants,
                                      selectedTypePrice: widget.price,
                                      pickedLocation: widget.pickedLocation,
                                      dateValue: widget.bookingdate,
                                      timeValue: widget.timeValue,
                                      notes: widget.notes,
                                    )));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                           translation(context).continue0,
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: appColorBlack,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          textStyle: TextStyle(fontSize: 17),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                ],
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              pickLocationCard(),
              SizedBox(height: 10),
              notesCard(),
              SizedBox(height: 10),
              bookingCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget pickLocationCard() {
    return Container(
      height: MediaQuery.of(context).size.height * 1.6 / 10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/location3.png",
                  height: 25,
                  width: 25,
                ),
                SizedBox(width: 5),
                Text(translation(context).address, style: TextStyle(fontSize: 17)),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      widget.pickedLocation,
                      style: TextStyle(color: Colors.black, fontSize: 11),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget notesCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 2.5 / 10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/notes.png",
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(width: 5),
                  Text(translation(context).notes, style: TextStyle(fontSize: 17.0)),
                ],
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Container(
                  child: Text(widget.notes),
                ),
              ),
              // SizedBox(height: 10.0),
              // Center(
              //   child: ElevatedButton(
              //     child: Text('Submit'),
              //     onPressed: () {},
              //     style: ElevatedButton.styleFrom(
              //         primary: appColorBlack,
              //         padding:
              //             EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              //         textStyle: TextStyle(fontSize: 15),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         )),
              //   ),
              // ),
            ],
          )),
    );
  }

  Widget bookingCard() {
    var dateFormate =
        DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.bookingdate));
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 2.6 / 10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/bookdate.png",
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(width: 7),
                  Text(translation(context).booking, style: TextStyle(fontSize: 17.0)),
                ],
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7 / 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey.shade200,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(translation(context).date + dateFormate,
                            style: TextStyle(fontSize: 15.0)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7 / 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey.shade200,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(translation(context).time + widget.timeValue,
                            style: TextStyle(fontSize: 15.0)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  _getLocation(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ss.PlacePicker(
              apiKey: "AIzaSyAi4yKthIBU-bHeuQHPgpJmdXnuLxKGc1s",
              useCurrentLocation: true,
              onPlacePicked: (valu) {
                Navigator.pop(context);

                setState(() {
                  _pickedLocation = valu.formattedAddress ?? '';
                });
              },
              resizeToAvoidBottomInset: false,
              initialPosition: qq.LatLng(29.378586, 47.990341),
            )));
  }
}
