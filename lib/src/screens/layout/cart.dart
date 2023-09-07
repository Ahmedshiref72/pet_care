import 'package:another_flushbar/flushbar.dart';
import 'package:demo_project/const/colors.dart';
import 'package:demo_project/localization/language_constants.dart';
import 'package:demo_project/src/blocs/getcart_bloc.dart';
import 'package:demo_project/src/blocs/removecart_bloc.dart';
import 'package:demo_project/src/elements/ps_button_widgets.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/getCartItem.dart';
import 'package:demo_project/src/screens/layout/checkoutProduct.dart';
import 'package:demo_project/src/screens/layout/serviceList.dart';
import 'package:demo_project/src/screens/user/login/login_container_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GetCartScreeen extends StatefulWidget {
  @override
  _GetCartState createState() => new _GetCartState();
}

class _GetCartState extends State<GetCartScreeen> {
  bool isPayment = false;
  var isLoading = false;

  @override
  void initState() {
    // _getCart();
    getCartBloc.getCartSink(userID);
    super.initState();
  }

  // _getCart() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var uri = Uri.parse('${baseUrl()}/get_cart_items');
  //   var request = new http.MultipartRequest("Post", uri);
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //   };
  //   request.headers.addAll(headers);
  //   request.fields.addAll({'user_id': userID});
  //   var response = await request.send();
  //   print(response.statusCode);
  //   String responseData = await response.stream.transform(utf8.decoder).join();
  //   var userData = json.decode(responseData);
  //   cartModel = GetCartModal.fromJson(userData);

  //   print(responseData);
  //   if (mounted)
  //     setState(() {
  //       isLoading = false;
  //     });
  // }

  // removeCart(String id) async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   var uri = Uri.parse('${baseUrl()}/remove_cart_items');
  //   var request = new http.MultipartRequest("Post", uri);
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //   };
  //   request.headers.addAll(headers);
  //   request.fields.addAll({'cart_id': id});
  //   // request.fields['user_id'] = userID;
  //   var response = await request.send();
  //   print(response.statusCode);
  //   String responseData = await response.stream.transform(utf8.decoder).join();
  //   var userData = json.decode(responseData);
  //   removeCartModal = RemoveCartModal.fromJson(userData);

  //   if (removeCartModal.responseCode == "1") {
  //     setState(() {
  //       cartModel = null;
  //     });
  //     _getCart();
  //   }

  //   print(responseData);

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
          backgroundColor: MyColors.color1,
          appBar: appbar(translation(context).cart, context),
          body: userID != '0'
              ? StreamBuilder<GetCartModel>(
                  stream: getCartBloc.getCartStream,
                  builder: (context, AsyncSnapshot<GetCartModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    // var getcartDeatil =
                    //     snapshot.data != null ? snapshot.data : (null);

                    return Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  snapshot.data!.cart != null
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount:
                                              snapshot.data!.cart!.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  18,
                                                ),
                                              ),
                                              child: _itmeList(
                                                snapshot.data!.cart![index],
                                                index,
                                                w,
                                              ),
                                            );
                                          },
                                        )
                                      : Center(
                                          child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              child: Image.asset(
                                                "assets/images/emptyCart.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              translation(context).cart_is_Empty,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                ],
                              ),
                            ),
                            Container(height: 15),
                            snapshot.data!.cartTotal != null
                                ? Card(
                                    margin: EdgeInsets.all(0),
                                    elevation: 10,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30,
                                          right: 30,
                                          bottom: 20,
                                          top: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                translation(context).total,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "\$${snapshot.data!.cartTotal.toString()}",
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          PSButtonWidget(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CheckoutProduct()),
                                              );
                                            },
                                            titleText: translation(context).checkout,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                        isPayment == true
                            ? Center(
                                child: CupertinoActivityIndicator(),
                              )
                            : Container()
                      ],
                    );

                    // return Text(snapshot.data!.restaurant!.serviceName??'');
                  })
              : Stack(
                  children: <Widget>[
                    Container(
                      width: SizeConfig.screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/guest.png',
                            width: SizeConfig.blockSizeHorizontal! * 100,
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical! * 3,
                          ),
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
                        ],
                      ),
                    )
                  ],
                )),
    );
  }

  Widget _itmeList(Cart cart, int index, double w) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => ProductDetails(
        //             productId: cart.productId,
        //           )),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              height: 130,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        0.0,
                      ),
                      child: Image.network(
                        cart.productImage!,
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cart.productName!,
                            style: TextStyle(
                                fontSize: 16,
                                color: appColorBlack,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(height: 5),
                          Text(
                            "\$${cart.price}",
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(height: 5),
                          Text(
                            "${translation(context).qty} ${cart.quantity}",
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        removecartBloc.removecartSink(cart.cartId!).then(
                          (cartData) {
                            print(cartData);
                            if (cartData.responseCode == "1") {
                              setState(() {
                                isLoading = false;
                              });
                              Flushbar(
                                backgroundColor: appColorWhite,
                                messageText: Text(
                                  translation(context).item_remove,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: appColorBlack,
                                  ),
                                ),
                                duration: Duration(seconds: 3),
                              )..show(context);
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              Flushbar(
                                backgroundColor: appColorWhite,
                                messageText: Text(
                                  translation(context).item_not_remove,
                                  style: TextStyle(
                                    fontSize: SizeConfig.blockSizeHorizontal,
                                    color: appColorBlack,
                                  ),
                                ),
                                duration: Duration(seconds: 3),
                              )..show(context);
                            }
                            getCartBloc.getCartSink(userID);
                          },
                        );
                      },
                      child: Container(

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

                                  //color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            Container(
                              height: w / 7.5,
                              width: w / 7.5,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
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
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
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
          ],
        ),
      ),
    );
  }
}
