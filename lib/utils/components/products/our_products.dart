import 'package:flutter/material.dart';
import 'package:shopify/data/our_products_data.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/utils/reusable/custom_text.dart';

class OurProducts extends StatefulWidget {
  const OurProducts({super.key});

  @override
  State<OurProducts> createState() => _OurProductsState();
}

class _OurProductsState extends State<OurProducts> {

  OurProductsData ourProductsData = OurProductsData();

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);    
    return Container(
      height: height * 0.14,
      width: width * 1,
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(left: width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(text: "Our Products Types", height: 0.04, width: 0.5,size: 0.05, color: Colors.black, bold: true),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: ourProductsData.ourProductsIcon.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      height: height * 0.11,
                      width: height * 0.11,
                      color: Colors.white,
                      margin: EdgeInsets.only(right: width * 0.023),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.01),
                                  child: Image.asset(ourProductsData.ourProductsIcon.values.elementAt(index))),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.transparent,
                              child: FittedBox(
                                child: Text(
                                  ourProductsData.ourProductsIcon.keys.elementAt(index),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}