import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/components/header_design.dart';
import 'package:shopify/utils/reusable/custom_text.dart';
import 'package:shopify/view/pages/products/product_info_page.dart';
import 'package:shopify/view_models/products/click_controller.dart';
import 'package:shopify/view_models/products/products_controller.dart';

class BrandProducts extends StatefulWidget {
  const BrandProducts({super.key});

  @override
  State<BrandProducts> createState() => _BrandProductsState();
}

class _BrandProductsState extends State<BrandProducts> {

  ClickController clickController = Get.find();
  ProductsController productsController = Get.find();

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
            SizedBox(height: height* 0.01),
            Divider(color: Colors.grey, height: height * 0.01),
            Padding(
              padding: EdgeInsets.only(left: width * 0.03),
              child: Row(
                children: [
                  const CustomText(text: 'Brand/Type: ', height: 0.05, width: 0.25, color: Colors.black, bold: true, size: 0.05),
                  SizedBox(width: width * 0.03),
                  Hero(
                    tag: clickController.productId.value,
                    child: Container(
                      height: height * 0.05,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        //border: Border.all(color: Colors.grey),
                        image: DecorationImage(
                          image: NetworkImage(clickController.brandImage.value),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: ListView.builder(
                  itemCount: productsController.subCategoryProducts.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        productsController.filterProductInfo(productsController.subCategoryProducts[index].id);
                        productsController.filterProductInfoCategoryProducts(productsController.subCategoryProducts[index].category,productsController.subCategoryProducts[index].id);
                        Get.to(const ProductInfoPage(),transition: Transition.topLevel);
                      },
                      child: Container(
                        height: height * 0.2,
                        width: width * 1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth) * 20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 2,
                              spreadRadius: 2,
                              offset: const Offset(2, 2),
                            ),
                          ]
                        ),
                        margin: EdgeInsets.symmetric(horizontal: width * 0.02,vertical: height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: productsController.subCategoryProducts[index].id,
                              child: Container(
                                height: height * 0.2,
                                width: width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular((width/Screen.designWidth) * 20),
                                    bottomLeft: Radius.circular((width/Screen.designWidth) * 20),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(productsController.subCategoryProducts[index].primaryImageUrl),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: height * 0.06,
                                    color: Colors.transparent,
                                    margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                                    child: Text(
                                      productsController.subCategoryProducts[index].productName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: (height / Screen.designHeight) * 8,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Container(
                                    height: height * 0.035,
                                    width: width * 1,
                                    //margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: height * 0.035,
                                          width: width * 0.08,
                                          color: Colors.transparent,
                                          child: const Center(
                                            child: FittedBox(
                                              child: Icon(Icons.star,color: Colors.yellow),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: width * 0.01),
                                        Expanded(
                                          child: CustomText(text: '${productsController.subCategoryProducts[index].ratings.toString()} / 5', height: 0.035, width: 1, color: Colors.black, bold: false, size: 0.04)
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: height * 0.005),
                                  Container(
                                    height: height * 0.025,
                                    width: width * 1,
                                    color: Colors.transparent,
                                    margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: height * 0.025,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColor.primaryColor,
                                                width: width * 0.005,
                                              )
                                            ),
                                            child: FittedBox(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                                                child: Text(
                                                  (productsController.subCategoryProducts[index].deliveryCharge!=0) ? '৳ ${productsController.subCategoryProducts[index].deliveryCharge.toString()}' : "Free Delivery",
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          )
                                        ),
                                        SizedBox(width: width * 0.01,),
                                        Expanded(
                                          child: Container(
                                            height: height * 0.025,
                                            margin: EdgeInsets.only(right: width * 0.06),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.deepOrange,
                                                width: width * 0.005,
                                              )
                                            ),
                                            child: FittedBox(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                                                child: const Text(
                                                  "Get Coins",
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: height * 0.005),
                                  Container(
                                    height: height * 0.035,
                                    width: width * 1,
                                    color: Colors.transparent,
                                    margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: height * 0.3,
                                            margin: EdgeInsets.only(right: width * 0.06),
                                            alignment: Alignment.centerLeft,  
                                            child: FittedBox(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                                                child: Text(
                                                  '৳ ${productsController.subCategoryProducts[index].price.toString()}',
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: height * 0.3,
                                            margin: EdgeInsets.only(right: width * 0.06),
                                            alignment: Alignment.centerLeft,  
                                            child: FittedBox(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                                                child: Text(
                                                  (productsController.subCategoryProducts[index].oldPrice !=0) ? '৳ ${productsController.subCategoryProducts[index].oldPrice.toString()}' : "",
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    decoration: TextDecoration.lineThrough,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
