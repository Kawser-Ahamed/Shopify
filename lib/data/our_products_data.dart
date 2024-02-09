import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopify/resource/assets/app_images.dart';

class OurProductsData{

  Map<String,String> ourProductsIcon = {
    "Cloth" : AppImages.cloth,
    "Electronics" : AppImages.electronicDevice,
    "Grocery" : AppImages.grocery,
    "Shoe" : AppImages.shoe,
  };

  List<Widget> searchPageIcons = [
    const Icon(CupertinoIcons.gift,color: Colors.blue),
    const Icon(Icons.tv,color: Colors.black),
    //const Icon(Icons.mobile_screen_share,color: Colors.orange),
    const Icon(Icons.man,color: Colors.red),
    const Icon(Icons.woman,color: Colors.pink),
    const Icon(Icons.pedal_bike,color: Colors.teal),
    const Icon(Icons.electric_bolt,color: Colors.deepOrange),
    const Icon(Icons.beach_access,color: Colors.green),
  ];
}