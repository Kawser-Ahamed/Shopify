import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/resource/assets/app_images.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/custom_text.dart';
import 'package:shopify/utils/reusable/names.dart';
import 'package:shopify/view/pages/products/search.dart';

class ShopifyAppBar extends StatefulWidget {
  const ShopifyAppBar({super.key});

  @override
  State<ShopifyAppBar> createState() => _ShopifyAppBarState();
}

class _ShopifyAppBarState extends State<ShopifyAppBar> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.13,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primaryColor,AppColor.secondaryColor],
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height * 0.18,
            width: width * 0.18,
            margin: EdgeInsets.only(left: width * 0.03,top: height * 0.05),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.appLogo),
              ),
            ),
          ),
          InkWell(
            onTap:(){
              Get.to(const Search(),transition: Transition.rightToLeftWithFade);
            },
            child: Container(
              height: height * 0.06,
              width: width * 0.75,
              margin: EdgeInsets.only(right: width * 0.03,top: height * 0.05,bottom: height*0.010),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(width * 0.02)),
                border: Border.all(color: Colors.black,width: width * 0.002),
              ),
              child: Row(
                children: [
                  SizedBox(width: width * 0.03),
                  Container(
                    height: height * 0.04,
                    width: width * 0.1,
                    color: Colors.transparent,
                    child: const FittedBox(
                      child: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  CustomText(text: "Search on ${Names.appName}", height: 0.04, width: 0.4,size: 0.3, color: Colors.black, bold: false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}