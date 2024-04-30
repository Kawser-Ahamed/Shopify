import 'package:flutter/material.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/components/products/categories.dart';
import 'package:shopify/utils/components/products/flash_sale.dart';
import 'package:shopify/utils/components/main_carousel.dart';
import 'package:shopify/utils/components/products/our_products.dart';
import 'package:shopify/utils/components/products/products.dart';
import 'package:shopify/utils/reusable/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Scaffold(
      body: Container(
        height: height * 1,
        width: width * 1,
        color: AppColor.backgroundColor,
        child: Column(
          children: [
            const ShopifyAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const MainCarousel(),
                    SizedBox(height: height * 0.01),
                    const OurProducts(),
                    SizedBox(height: height * 0.01),
                    const Categories(),
                    SizedBox(height: height * 0.01),
                    const FlashSale(),
                    SizedBox(height: height * 0.01),    
                    const Products(),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}