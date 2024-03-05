import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/colors/app_color.dart';

class CartHeaderDesign extends StatefulWidget {
  final int animationWidth;
  const CartHeaderDesign({super.key, required this.animationWidth});

  @override
  State<CartHeaderDesign> createState() => _CartHeaderDesignState();
}

class _CartHeaderDesignState extends State<CartHeaderDesign> {

  bool isExpanded = false;

  @override
  void initState() {
    Timer(const Duration(microseconds: 500), () {
      isExpanded = true;
      setState(() {
        
      });
     });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Container(
      height:height * 0.1,
      width: width * 1,
      color: Colors.transparent,
      margin: EdgeInsets.only(top: height * 0.02),
      child: Stack(
        alignment: Alignment.center,
        children: [
           Positioned(
            top: height * 0.015,
            left: 0,
            right: 0,
            bottom: height * 0.065,
            child: Container(
              color: Colors.grey.shade300,
            ),
          ),
          Positioned(
            top: height * 0.015,
            left: 0,
            bottom: height * 0.065,
            child: AnimatedContainer(
              duration: const Duration(seconds: 2),
              width: (isExpanded) ? (width/widget.animationWidth)-width * 0.02 : 0,
              color: AppColor.primaryColor,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        height: height * 0.05,
                        width: height * 0.05,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          shape: BoxShape.circle,
                          //border: Border.all(color: Colors.black),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all((width/Screen.designWidth)*5),
                          child: FittedBox(
                            child: Text("1",
                              style: TextStyle(
                                fontSize: (width/Screen.designWidth) *40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text("Cart",
                        style: GoogleFonts.aBeeZee(
                          fontSize: (width/Screen.designWidth) * 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: height * 0.05,
                        width: height * 0.05,
                        decoration: BoxDecoration(
                          color: (widget.animationWidth == 2) ? AppColor.primaryColor : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: (widget.animationWidth == 2) ? Colors.transparent : Colors.grey.shade400,width: (width/Screen.designWidth)*5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all((width/Screen.designWidth)*5),
                          child: FittedBox(
                            child: Text("2",
                              style: TextStyle(
                                fontSize: (width/Screen.designWidth) *40,
                                fontWeight: FontWeight.bold,
                                color: (widget.animationWidth == 2) ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text("Order",
                        style: GoogleFonts.aBeeZee(
                          fontSize: (width/Screen.designWidth) * 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                       Container(
                        height: height * 0.05,
                        width: height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade400,width: (width/Screen.designWidth)*5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all((width/Screen.designWidth)*5),
                          child: FittedBox(
                            child: Text("3",
                              style: TextStyle(
                                fontSize: (width/Screen.designWidth) *40,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text("Delivery",
                        style: GoogleFonts.aBeeZee(
                          fontSize: (width/Screen.designWidth) * 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}