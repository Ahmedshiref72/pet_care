import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/localization/language_constants.dart';
import 'package:demo_project/src/blocs/category_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/getAllProdCat.dart';
import 'package:demo_project/src/screens/layout/new_layouts_product/productList.dart';
import 'package:demo_project/src/screens/layout/new_store_detail/storeDeail2.dart';
import 'package:flutter/material.dart';

import '../../../../const/colors.dart';
import '../../../models/serviceDetail_model.dart';
import '../../user/register/register_view.dart';

class ProductCategory extends StatefulWidget {
  ProductCategory({this.initialIndex});

  final int? initialIndex;
  @override
  ProductCategoryState createState() => ProductCategoryState();
}

class ProductCategoryState extends State<ProductCategory> {
  @override
  void initState() {
    categoryBloc.categorySink();
    // serviceBloc.serviceSink();
    super.initState();
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      categoryBloc.categorySink();
    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
     /* appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          translation(context).product_Category,
          style: TextStyle(color: appColorBlack, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        // leading: Icon(
        //   Icons.arrow_back,
        //   color: Colors.black,
        // ),
      ),*/
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: RefreshIndicator(
          onRefresh: _pullRefresh,
          color: appColorBlack,
          child: SingleChildScrollView(
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
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*Padding(
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
                          translation(context).product_Category,
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
                SizedBox(height: 10),
                StreamBuilder<GetAllProdCategory>(
                  stream: categoryBloc.categoryStream,
                  builder:
                      (context, AsyncSnapshot<GetAllProdCategory> snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: Center(
                          child:
                              CircularProgressIndicator(color: appColorBlack),
                        ),
                      );
                    }
                    List<Category>? allCate = snapshot.data!.category != null
                        ? snapshot.data!.category
                        : [];
                    return allCate!.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: allCate.length,
                            itemBuilder: (context, int index) {
                              return serviceCard(allCate[index]);
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
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget serviceCard(Category data) {
    // String? id = data.id;
    //print("id: "+id);
    return InkWell(
      onTap: () {
        print("click");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductList(id: data.id)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        //color: Colors.redAccent,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: data.image!,
                          imageBuilder: (context, imageProvider) => Container(
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
                                valueColor: new AlwaysStoppedAnimation<Color>(
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
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        data.cName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
    );
  }
}

Widget resCard(BuildContext context, Restaurant2 data) {
  // String? id = data.id;
  //print("id: "+id);
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewStoreDetailScreen(
                  data.resId,
                  isFromNew: true,
                )),
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      //color: Colors.redAccent,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: data.resImage!.resImag0!,
                        imageBuilder: (context, imageProvider) => Container(
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
                              valueColor: new AlwaysStoppedAnimation<Color>(
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
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      data.resName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
  );
}
