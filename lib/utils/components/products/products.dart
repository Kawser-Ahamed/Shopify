import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/custom_text.dart';
import 'package:shopify/utils/reusable/loading.dart';
import 'package:shopify/view/pages/products/product_info_page.dart';
import 'package:shopify/view_models/products/click_controller.dart';
import 'package:shopify/view_models/products/products_controller.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  ProductsController productsController = Get.put(ProductsController());
  ClickController clickController = Get.put(ClickController());

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Card(
      color: Colors.red,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.03),
                  child: const CustomText(text: "Just For You", height: 0.035, width: 1, color: Colors.black, bold: true, size: 0.08
                ),
              )
            ),
            FutureBuilder(
              future: productsController.getProducts(), 
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Obx(() => GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: width * 0.005,
                      mainAxisSpacing: height * 0.020,
                      childAspectRatio: width / (height / 1.3),
                    ), 
                    itemCount: productsController.productsData.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          productsController.filterProductInfo(productsController.productsData[index].id);
                          productsController.filterProductInfoCategoryProducts(productsController.productsData[index].category,productsController.productsData[index].id);
                          Get.to(const ProductInfoPage(),transition: Transition.topLevel);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: width * 0.02),
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
                          child: Column(
                            children: [
                              Hero(
                                tag: productsController.productsData[index].id,
                                child: Container(
                                  height: height * 0.2,
                                  width: width * 1,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular((width/Screen.designWidth) * 20),
                                      topRight: Radius.circular((width/Screen.designWidth) * 20),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(productsController.productsData[index].primaryImageUrl),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: height * 0.06,
                                width: width * 1,
                                color: Colors.transparent,
                                margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                                child: Text(
                                  productsController.productsData[index].productName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: (height / Screen.designHeight) * 8,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
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
                                      child: CustomText(text: '${productsController.productsData[index].ratings.toString()} / 5', height: 0.035, width: 1, color: Colors.black, bold: false, size: 0.04)
                                    ),
                                  ],
                                ),
                              ),
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
                                              (productsController.productsData[index].deliveryCharge!=0) ? '৳ ${productsController.productsData[index].deliveryCharge.toString()}' : "Free Delivery",
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
                                              '৳ ${productsController.productsData[index].price.toString()}',
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
                                              (productsController.productsData[index].oldPrice !=0) ? '৳ ${productsController.productsData[index].oldPrice.toString()}' : "",
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
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ));
                }
                else{
                  return Center(child: Loading(color: AppColor.primaryColor, size: 0.08),);
                }
              },
            ),
            SizedBox(height: height * 0.03),
            Center(
              child: Text("You've reached at the end.",
              textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  fontSize: (width/Screen.designWidth) * 25,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Center(
              child: Text("Do a search for keep exploring!",
                style: GoogleFonts.aBeeZee(
                  fontSize: (width/Screen.designWidth) * 25,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }
}