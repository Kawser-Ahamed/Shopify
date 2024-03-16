import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/our_products_data.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/cart_icon_design.dart';
import 'package:shopify/utils/reusable/custom_text.dart';
import 'package:shopify/utils/reusable/names.dart';
import 'package:shopify/view/pages/products/product_info_page.dart';
import 'package:shopify/view_models/products/click_controller.dart';
import 'package:shopify/view_models/products/products_controller.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  ProductsController productsController = Get.find();
  ClickController clickController = Get.put(ClickController());
  OurProductsData ourProductsData = OurProductsData();

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height* 1,
        width: width * 1,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.1,
              width: width * 1,
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(horizontal: width * 0.03),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: ()=>Get.back(),
                    child: Container(
                      height: height * 0.03,
                      width: width * 0.08,
                      color: Colors.transparent,
                      child: const FittedBox(
                        child: Icon(Icons.arrow_back_ios,color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: CustomText(text: "Search On ${Names.appName}", height: 0.04, width: 0.5, color: Colors.black, bold: false, size: 0.10),
                  ),
                  const CartIconsDesign(iconsHeight: 0.06, iconWidth: 0.06, color: Colors.black),
        
                ],
              ),
            ),
            SizedBox(height: height * 0.02), 
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: CustomText(text: "${Names.appName} Products", height: 0.04, width: 0.5, color: AppColor.primaryColor, bold: true, size: 0.1),
            ),
            SizedBox(height: height * 0.01,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: height * 0.055,
                      width: width * 1,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth) * 50)),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: TextFormField(
                          controller: clickController.productName,
                          decoration: const InputDecoration(
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintText: "Search by product name",
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.01,),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          productsController.searchFilter(clickController.productName.text,clickController.lowPrice.value.toDouble(),clickController.highPrice.value.toDouble(),clickController.ratings.value);
                        }); 
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(AppColor.secondaryColor),
                      ), 
                      child: const FittedBox(child: Text("Search",style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01,),  
            ExpansionTile(
              leading: const FittedBox(child: Icon(Icons.filter_alt_outlined)),
              title: Text("Filter Search",
                style: TextStyle(
                  fontSize: width * 0.05,
                ),
              ),
              backgroundColor: Colors.grey.shade100,               
              children: [
                Container(
                  height: height * 0.16,
                  width: width * 1,
                  color: Colors.white,
                  child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.05),
                                  child: const CustomText(text: "Low Price", height: 0.03, width: 1, color: Colors.green, bold: true, size: 0.08)
                                ),
                                Obx(() => Container(
                                  height: height * 0.05,
                                  color: Colors.transparent,
                                  child: Slider(
                                    activeColor: AppColor.secondaryColor,
                                    value: clickController.lowPrice.value, 
                                    max: 10000,
                                    divisions: 100,
                                    onChangeEnd: (value) {
                                      setState(() {
                                        productsController.searchFilter(clickController.productName.text,clickController.lowPrice.value.toDouble(),clickController.highPrice.value.toDouble(),clickController.ratings.value);
                                      });
                                    },
                                    label: clickController.lowPrice.round().toString(),             
                                    onChanged:(value) {
                                      clickController.lowPrice.value = value;
                                    },
                                  ),
                                ),),
                              ],
                            )
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.05),
                                  child: const CustomText(text: "Hight Price", height: 0.03, width: 1, color: Colors.red, bold: true, size: 0.08)
                                ),
                                Obx(() => Container(
                                  height: height * 0.05,
                                  color: Colors.transparent,
                                  child: Slider(
                                    activeColor: AppColor.secondaryColor,
                                    value: clickController.highPrice.value, 
                                    max: 100000,
                                    divisions: 1000,
                                    onChangeEnd: (value) {
                                      setState(() {
                                        productsController.searchFilter(clickController.productName.text,clickController.lowPrice.value.toDouble(),clickController.highPrice.value.toDouble(),clickController.ratings.value);
                                      });
                                    },
                                    label: clickController.highPrice.value.round().toString(),             
                                    onChanged:(value) {
                                      setState(() {
                                        clickController.highPrice.value = value;
                                      });
                                    },
                                  ),
                                ),),
                              ],
                            )
                          ),              
                        ],
                      )
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: height * 0.005),
                              child: InkWell(
                                onTap:(){
                                  setState(() {
                                    clickController.ratings.value = (index+1).toDouble();
                                    productsController.searchFilter(clickController.productName.text,clickController.lowPrice.value.toDouble(),clickController.highPrice.value.toDouble(),clickController.ratings.value);
                                  });
                                },
                                child: Obx(() => Container(
                                  height: height * 0.005,
                                  width: width * 0.15,
                                  margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                                  decoration: BoxDecoration(
                                    color: ((index+1).toDouble() == clickController.ratings.value) ? AppColor.secondaryColor : Colors.grey.shade200,
                                    borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20))
                                  ),
                                  child: Column(
                                      children: [
                                        Container(
                                          height: height * 0.04,
                                          width: width * 0.06,
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width * 0.003,vertical: height * 0.003),
                                            child: const FittedBox(child: Icon(Icons.star,color: Colors.yellow,)),
                                          ),
                                        ),
                                        CustomText(text: " ${index+1} Star", height: 0.03, width: 0.1, color: ((index+1).toDouble() == clickController.ratings.value) ? Colors.white : Colors.black, bold: false, size: 0.08)
                                      ],
                                    ),
                                ),),
                              ),
                            );
                          },
                        ),
                      )
                    )
                  ],
                ),)
              ],
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: width * 0.005,
                      mainAxisSpacing: height * 0.020,
                      childAspectRatio: width / (height / 1.3),
                    ), 
                    itemCount: productsController.filterProducts.length,
                    //physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                           productsController.filterProductInfo(productsController.filterProducts[index].id);
                           productsController.filterProductInfoCategoryProducts(productsController.filterProducts[index].category,productsController.filterProducts[index].id);
                           Get.to(const ProductInfoPage(),transition: Transition.rightToLeftWithFade);
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
                                      image: NetworkImage(productsController.filterProducts[index].primaryImageUrl),
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
                                  productsController.filterProducts[index].productName,
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
                                      child: CustomText(text: '${productsController.filterProducts[index].ratings.toString()} / 5', height: 0.035, width: 1, color: Colors.black, bold: false, size: 0.04)
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
                                              (productsController.filterProducts[index].deliveryCharge!=0) ? '৳ ${productsController.productsData[index].deliveryCharge.toString()}' : "Free Delivery",
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
                                              '৳ ${productsController.filterProducts[index].price.toString()}',
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
                                              (productsController.filterProducts[index].oldPrice !=0) ? '৳ ${productsController.productsData[index].price.toString()}' : "",
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
                  ),
              )
            ),          
          ],
        ),
      ),
    );
  }
}