import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/assets/app_images.dart';
import 'package:shopify/utils/reusable/app_logo_animation.dart';
import 'package:shopify/utils/reusable/loading.dart';
import 'package:shopify/view/pages/navigation_pages/mainpage.dart';
import 'package:shopify/view_models/user/user_information_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  ShopifyUserInformationViewModel shopifyUserInformationViewModel = Get.put(ShopifyUserInformationViewModel());

  void checkUserLoginInformation(){
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(!shopifyUserInformationViewModel.isLoading.value){
        Get.to(const MainPage());
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    shopifyUserInformationViewModel.getUserInformation();
    checkUserLoginInformation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Scaffold(
      body: Container(
        height: height * 1,
        width: width * 1,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(AppImages.splashScreenImage),
            fit: BoxFit.fill,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogoAnimation(),
            Loading(color: Colors.white, size: 0.08),
          ],
        ),
      ),
    );
  }
}