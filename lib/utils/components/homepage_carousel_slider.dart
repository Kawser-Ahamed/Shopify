import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopify/data/homepage_carousel_data.dart';
import 'package:shopify/data/screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:shopify/resource/colors/app_color.dart';

class HomePageCarouselSlider extends StatefulWidget {
  const HomePageCarouselSlider({super.key});

  @override
  State<HomePageCarouselSlider> createState() => _HomePageCarouselSliderState();
}

class _HomePageCarouselSliderState extends State<HomePageCarouselSlider> {
  
  HomePageCarouselData homePageCarouselData = HomePageCarouselData();

  int dotIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Container(
      height: height * 0.2,
      width: width * 1,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: height * 0.17,
            width: width * 1,
            color: Colors.white,
            child: CarouselSlider(
              items: homePageCarouselData.homepageCarouselList.map((element){
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.01,vertical: height*0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth) * 30)),
                    color: Colors.green,
                    image: DecorationImage(
                      image: AssetImage(element),
                      fit: BoxFit.cover,
                    )
                  ),
                );
              }).toList(), 
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    dotIndex = index;
                  });
                },
              )
            ),
          ),
          Container(
            height: height * 0.03,
            width: width * 1,
            color: Colors.transparent,
            child: DotsIndicator(
              dotsCount: homePageCarouselData.homepageCarouselList.length,
              position: dotIndex,
              decorator: DotsDecorator(
                activeColor: AppColor.primaryColor,
                //activeSize: Size(height * 0.06, height* 0.03),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.05)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}