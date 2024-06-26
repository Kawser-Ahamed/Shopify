import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/view_models/carasoul/main_carasoul_controller.dart';

class MainCarousel extends StatefulWidget {
  const MainCarousel({super.key});

  @override
  State<MainCarousel> createState() => _MainCarouselState();
}

class _MainCarouselState extends State<MainCarousel> {

  MainCarasoulController mainCarasoulController = Get.find();

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Container(
      height: height *0.25,
      width: width * 1,
      color: Colors.white,
      child:Obx((){
        return CarouselSlider(
          items: mainCarasoulController.mainCarasoulData.map((element){
          return Container(
            height: height * 0.25,
            width: width * 1,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: NetworkImage(element.imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          );
        }).toList(), 
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            viewportFraction: 1.0,
            aspectRatio: 1.0,
          ),
        );
      }),
    );
  }
}