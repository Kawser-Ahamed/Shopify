import 'package:flutter/material.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/utils/components/products/categories_sildebar.dart';
import 'package:shopify/utils/components/header_design.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key});

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Scaffold(
      body: Container(
        height: height * 1,
        width: width * 1,
        color: Colors.white,
        child: Column(
          children: [
            const HeaderDesign(),
            Divider(color: Colors.grey,height: height*0.02),
            const Expanded(
              child: CategoriesSideBar(),
            ),
          ],
        ),
      ),
    );
  }
}