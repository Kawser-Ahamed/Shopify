import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shopify/view/pages/cart.dart';
import 'package:shopify/view/pages/homepage.dart';
import 'package:shopify/view/pages/profile.dart';
import 'package:shopify/view/pages/settings.dart';

class NavBarController extends GetxController{

  RxInt pageIndex = 0.obs;

  List<GButton> navBarIcons = [
    const GButton(icon: Icons.home,text: "Home"),
    const GButton(icon: Icons.person,text: "Profile"),
    const GButton(icon: CupertinoIcons.cart,text: "Cart"),
    const GButton(icon: Icons.menu,text: "Menu"),
  ];
  List<dynamic> navBarPages = [
    const HomePage(),
    const Profile(),
    const Cart(),
    const Settings(),
  ];
}