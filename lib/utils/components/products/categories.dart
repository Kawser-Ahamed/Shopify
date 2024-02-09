import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/custom_text.dart';
import 'package:shopify/utils/reusable/loading.dart';
import 'package:shopify/utils/reusable/names.dart';
import 'package:shopify/view/pages/products/all_categories.dart';
import 'package:shopify/view/pages/products/category_products.dart';
import 'package:shopify/view_models/products/categories_controller.dart';
import 'package:shopify/view_models/products/click_controller.dart';
import 'package:shopify/view_models/products/products_controller.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  CategoriesController categoriesController = Get.put(CategoriesController());
  ClickController clickController = Get.put(ClickController());
  ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Container(
      height: height * 0.42,
      width: width * 1,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "${Names.appName} Catagories", height: 0.04, width: 0.5,size: 0.05, color: Colors.black, bold: true),
                    const CustomText(text: 'Recommended for you', height: 0.04, width: 0.5,size: 0.05, color: Colors.black, bold: false),
                  ],
                ),
                InkWell(
                  onTap: (){
                    Get.to(const AllCategories());
                  },
                  child: Container(
                    height: height * 0.04,
                    width: width * 0.25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: AppColor.primaryColor,
                        width: width * 0.005,
                      )
                    ),
                    child: FittedBox(
                      child: InkWell(
                        onTap: (){
                          Get.to(const AllCategories());
                        },
                        child: const Text("Explore >",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: height * 0.34,
              width: width * 1,
              color: Colors.transparent,
              child: FutureBuilder(
                future: categoriesController.getShopifyCategories(), 
                  builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return Obx((){
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: width * 0.3,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: categoriesController.categoriesData.length,
                        itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            clickController.category.value = categoriesController.categoriesData[index].name;
                            productsController.filterCategoryProducts(clickController.category.value);
                            Get.to(const CategoryProducts());
                          },
                          child: Container(
                            height: height * 0.3,
                            width: width * 0.3,
                            color: Colors.transparent,
                            margin: EdgeInsets.symmetric(horizontal: width * 0.01,vertical: height * 0.002),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.all(Radius.circular(height * 0.01)),
                                      image: DecorationImage(
                                        image: NetworkImage(categoriesController.categoriesData[index].imageUrl),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(categoriesController.categoriesData[index].name,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: (width>=600) ? (width/Screen.designWidth) * 15 : (width/Screen.designWidth) * 20,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        );
                      },);
                    });
                  }
                  else{
                    return Center(child: Loading(color: AppColor.primaryColor, size: 0.08));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}