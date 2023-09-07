import 'package:flutter/material.dart';

import '../../../localization/language_constants.dart';
import 'catWiseSeviceList.dart';
import 'multihome.dart';

class FirstContainer extends StatelessWidget {
  const FirstContainer(this.id,
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
          height: 200,
          width: MediaQuery.of(context).size.width * .9,
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
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  translation(context).get_your_medicine_at_home_by_online_order,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10,),
                Container(
                  width:  MediaQuery.of(context).size.width * .4,
                  height: 50,
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
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      translation(context).order_Now,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.blueGrey
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
