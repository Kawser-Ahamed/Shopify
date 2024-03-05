import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shopify/data/navbar_controller.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/view_models/cart/cart_view_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  NavBarController navBarController = Get.put(NavBarController());
  CartViewModel cartViewModel = Get.put(CartViewModel());
  
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenHeight(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: navBarController.navBarPages[navBarController.pageIndex.value],
        bottomNavigationBar: Container(
          height: height * 0.1,
          width: width * 1,
          color: AppColor.primaryColor,
          child: GNav(
            selectedIndex: navBarController.pageIndex.value,
            backgroundColor: AppColor.primaryColor,
            color: Colors.white,
            activeColor: Colors.black,
            gap: width * 0.01,
            iconSize: width*0.04,
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            textSize: width * 0.03,
            tabBackgroundColor: Colors.grey.shade100,
            style: GnavStyle.google,
            tabs: navBarController.navBarIcons,
            onTabChange: (int currentIndex){
              setState(() {
                navBarController.pageIndex.value = currentIndex;
              });
            },
          ),
        ),
      ),
    );
  }
}