import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shopify/resource/assets/app_images.dart';
import 'package:shopify/resource/colors/app_color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primaryColor,AppColor.secondaryColor],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 400.h,
            width: 400.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.appLogo),
              ),
            ),
          ),
          SpinKitThreeBounce(
            color: Colors.white,
            size: 100.sp,
          ),
        ],
      )
    );
  }
}