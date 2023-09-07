import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../../localization/language_constants.dart';
import 'catWiseSeviceList.dart';
import 'multihome.dart';

class OffersContainer extends StatelessWidget {
  const OffersContainer(this.id,
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
          height: 150,
          width: MediaQuery.of(context).size.width * .5,
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
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text('  69% OFF',style: TextStyle(
                          color: Colors.white
                      ),),
                      width: 73,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50)
                          )
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            text,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Spacer(),
                          Image.asset(
                            'assets/images/gen$image.png',  // Replace with the actual path to your image
                            width: 40,
                            height: 50,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width:  MediaQuery.of(context).size.width * .3,
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 5,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            translation(context).order_Now,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.blueGrey
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          )
          ,
        ),
      ),
    );
  }
}
