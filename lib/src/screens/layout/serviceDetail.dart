// ignore_for_file: unused_field, unrelated_type_equality_checks

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/localization/language_constants.dart';
import 'package:demo_project/src/blocs/servicedetail_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/serviceDetail_model.dart';

import 'package:demo_project/src/screens/layout/bookService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ServiceDetailScreen extends StatefulWidget {
  String id;
  ServiceDetailScreen(this.id);
  @override
  State<StatefulWidget> createState() {
    return _ServiceDetailScreenState(this.id);
  }
  // @override
  // _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  String id;
  _ServiceDetailScreenState(this.id);

  // var json;

  String? vid;
  String? resid;
  String? serviceid;
  String? price;
  String? reviewCount;
  String? orientation;

  var selectImg = "";
  var rateValue = 0;
  TextEditingController _ratingcontroller = TextEditingController();

  @override
  void initState() {
    print(id);
    _pullRefresh();
    super.initState();
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      serviceDetailBloc.serviceDetailSink(id);
    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(

          color: Colors.black, //change your color here
        ),
        title: Text(
          translation(context).doctor_Details,
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
                borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // print(vid);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookService(
                                    vid!, resid!, serviceid!, price!)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image.asset("assets/images/chat.png",
                          //     height: 20, width: 20),
                          // SizedBox(width: 8),
                          Text(translation(context).book_an_Appointment),
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
      body: StreamBuilder<ServiceDetailModel>(
          stream: serviceDetailBloc.serviceDetailStream,
          builder: (context, AsyncSnapshot<ServiceDetailModel> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: appColorBlack,
              ));
            }
            Restaurant? getServiceDeatil = snapshot.data!.restaurant != null
                ? snapshot.data!.restaurant
                : (null);

            List<Review>? getAllReview =
                snapshot.data!.review != null ? snapshot.data!.review : (null);

            resid = snapshot.data!.restaurant!.resId;
            serviceid = snapshot.data!.restaurant!.id;
            vid = snapshot.data!.restaurant!.vId;
            price = snapshot.data!.restaurant!.servicePrice!;
            reviewCount = snapshot.data!.review!.length.toString();

            print(">>>>>>>>>>>>>" + resid!);
            print(">>>>>>>>>>>>>" + serviceid!);
            print(">>>>>>>>>>>>>" + vid!);
            print(">>>>>>>>>>>>>" + price!);

            return bodyData(getServiceDeatil!, getAllReview!);

            // return Text(snapshot.data!.restaurant!.serviceName??'');
          }),
    );
  }

  Widget bodyData(Restaurant data, List<Review> review) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            elevation: 5,
            shadowColor: Colors.blue,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Color(0xff1479FF),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                      backgroundImage: NetworkImage(data.serviceImage!.first),
                      radius: 100),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${data.serviceName}',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    '${data.serviceShort}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: 12,
              start: 15,
              end: 15,
            ),
            child: Container(
              width: 347,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translation(context).biography,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "${data.serviceDescription}",
                      style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: 20,
            ),
            child: Text(
              '${translation(context).fee} ${data.servicePrice} KD',
              style: TextStyle(fontSize: 28, color: Color(0xff1D3A62)),
            ),
          ),
        ],
      ),
    );
  }

  Widget recentDetails(data) {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(3),
          child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) =>
                //           ViewPublicPost(id: document.postId)),
                // );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    child: CupertinoActivityIndicator(),
                    width: 35.0,
                    height: 35.0,
                    padding: EdgeInsets.all(10.0),
                  ),
                  errorWidget: (context, url, error) => Material(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    clipBehavior: Clip.hardEdge,
                  ),
                  imageUrl: data,
                  width: 35.0,
                  height: 35.0,
                  fit: BoxFit.cover,
                ),
              )),
        ));
  }

  Widget reviewWidget(List<Review> model) {
    return model.length > 0
        ? ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: model.length > 5 ? 5 : model.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return model[index].revUserData == null
                  ? Container()
                  : InkWell(
                      onTap: () {},
                      child: Center(
                        child: Container(
                          child: SizedBox(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Card(
                                        elevation: 4.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          // decoration: BoxDecoration(
                                          //     color: Colors.grey[200],
                                          //     borderRadius:
                                          //         BorderRadius.circular(0.0)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            child: CachedNetworkImage(
                                              imageUrl: model[index]
                                                  .revUserData!
                                                  .profilePic!,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Center(
                                                child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2.0,
                                                    valueColor:
                                                        new AlwaysStoppedAnimation<
                                                                Color>(
                                                            appColorBlack),
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(width: 10.0),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(height: 10.0),
                                            Text(
                                              model[index]
                                                  .revUserData!
                                                  .username!,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),

                                            Container(height: 5),
                                            Text(
                                              model[index].revText!,
                                              style: TextStyle(
                                                color: Colors.black,
                                                // fontWeight: FontWeight.w700,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.clip,
                                            ),
                                            // Text(
                                            //   dateformate,
                                            //   style: TextStyle(fontSize: 12),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      RatingBar.builder(
                                        initialRating: double.parse(
                                            model[index].revStars!),
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 15,
                                        ignoreGestures: true,
                                        unratedColor: Colors.grey,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ],
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 10),
                                  //   child: Container(
                                  //     height: 0.8,
                                  //     color: Colors.grey[300],
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ));
            })
        : Text(translation(context).no_reviews_found);
  }
}

class AppButton extends StatelessWidget {
  AppButton({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.color,
    required this.textColor,
    required this.size,
    required this.onChange,
  }) : super(key: key);
  final String text;
  final double width;
  final double height;
  final Color color;
  final Color textColor;
  final double size;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () {
          onChange();
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) {
          //       return  AppointmentDetails();
          //     }));
        },
        height: height,
        minWidth: width,
        color: color,
        textColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Text(
          text,
          style: TextStyle(fontSize: size),
        ));
  }
}

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    Key? key,
    required this.icon,
    required this.containerColor,
    required this.iconColor,
    required this.sizeofpadding,
  }) : super(key: key);

  final IconData icon;
  final Color containerColor;
  final Color iconColor;
  final double sizeofpadding;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shadowColor: Colors.blue,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: 31,
        height: 36,
        decoration: BoxDecoration(
            color: containerColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: sizeofpadding),
          child: Icon(
            icon,
            color: iconColor,
            size: 23,
          ),
        ),
      ),
    );
  }
}
