import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/const/colors.dart';
import 'package:demo_project/localization/language_constants.dart';
import 'package:demo_project/src/blocs/servicelist_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/serviceList_model.dart';

import 'package:demo_project/src/screens/layout/serviceDetail.dart';
import 'package:demo_project/src/screens/user/register/register_view.dart';
import 'package:flutter/material.dart';

import 'package:readmore/readmore.dart';

class ServiceList extends StatefulWidget {
  @override
  ServiceListState createState() => ServiceListState();
}

PreferredSize appbar(String title, BuildContext context) {
  return PreferredSize(
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
            bottom: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            /*  Padding(
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
                width: MediaQuery.of(context).size.width*.2,
              ),*/
              Text(
                title,
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
  );
}

class ServiceListState extends State<ServiceList> {
  @override
  void initState() {
    _pullRefresh();
    super.initState();
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(
      Duration(milliseconds: 1000),
    );
    setState(() {
      serviceBloc.serviceSink();
    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: appbar(translation(context).doctors, context),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        color: appColorBlack,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(6),
              //       color: Colors.white,
              //     ),
              //     child: TextField(
              //       decoration: InputDecoration(
              //         hintText: "Search for home service",
              //         hintStyle: TextStyle(fontSize: 14),
              //         prefixIcon: Padding(
              //           padding: const EdgeInsets.all(16.0),
              //           child: Image.asset(
              //             "assets/images/search.png",
              //             height: 10,
              //           ),
              //         ),
              //         border: InputBorder.none,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 8),
              StreamBuilder<ServiceListModel>(
                  stream: serviceBloc.serviceListStream,
                  builder: (context, AsyncSnapshot<ServiceListModel> snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: Center(
                          child:
                              CircularProgressIndicator(color: appColorBlack),
                        ),
                      );
                    }
                    List<Services>? allService = snapshot.data!.services != null
                        ? snapshot.data!.services
                        : [];
                    return allService!.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: allService.length,
                            itemBuilder: (context, int index) {
                              return serviceCard(allService[index]);
                            },
                          )
                        : Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 200,
                                width: 200,
                                child: Image.asset(
                                  "assets/images/noservice.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                translation(context).dont_have_any_Service,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceCard(Services data) {
    String? id = data.id;
    //print("id: "+id);
    return InkWell(
      onTap: () {
        // print("click");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServiceDetailScreen(id!)),
        );
      },
      child: Container(
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
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            //color: Colors.redAccent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: data.serviceImage!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Center(
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            appColorBlack),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Center(child: Text(translation(context).image_Not_Found)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          data.serviceName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "\$" + data.servicePrice! + "/h",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: ReadMoreText(
                        data.serviceDescription!,
                        trimLines: 2,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                        trimMode: TrimMode.Line,
                        trimCollapsedText: translation(context).read_more,
                        trimExpandedText: translation(context).read_less,
                        colorClickableText: appColorYellow,
                        lessStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: appColorBlack,
                          decoration: TextDecoration.underline,
                        ),
                        moreStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: appColorBlack,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            data.storeAddress!,
                            maxLines: 1,
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        // ElevatedButton(
                        //   style: ButtonStyle(
                        //     overlayColor:
                        //         MaterialStateProperty.all(Colors.white30),
                        //     minimumSize:
                        //         MaterialStateProperty.all(const Size(40, 30)),
                        //     backgroundColor:
                        //         MaterialStateProperty.all(Colors.black),
                        //     shape: MaterialStateProperty.all(
                        //       RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(5),
                        //       ),
                        //     ),
                        //   ),
                        //   onPressed: () {},
                        //   child: Text(
                        //     data.priceUnit!,
                        //     style: TextStyle(color: Colors.white, fontSize: 12),
                        //   ),
                        // ),
                      ],
                    )
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
