import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/custom_text.dart';
import 'package:shopify/utils/reusable/loading.dart';
import 'package:shopify/view/pages/products/product_info_page.dart';
import 'package:shopify/view_models/products/products_controller.dart';

class FlashSale extends StatefulWidget {
  const FlashSale({super.key});

  @override
  State<FlashSale> createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSale> {
  
  ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Container(
        color: Colors.white,
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(left: width*0.03),
          child: Column(
            children: [
              const CustomText(text: "Flash Sale", height: 0.05, width: 1, color: Colors.black, bold: true, size: 0.05), 
              FutureBuilder(
                future: productsController.getFlashSaleProducts(), 
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: Loading(color: AppColor.primaryColor, size: 0.08));
                  }
                  else if(snapshot.hasError){
                    return Center(child: Loading(color: AppColor.primaryColor, size: 0.08));
                  }
                  else{
                    return Obx(() => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          productsController.flashSaleProductsData.length, (index){
                          return InkWell(
                            onTap:(){
                              productsController.filterFlashSaleProductInfo(productsController.flashSaleProductsData[index].id);
                              productsController.filterProductInfoCategoryProducts(productsController.flashSaleProductsData[index].category,productsController.flashSaleProductsData[index].id);
                              Get.to(const ProductInfoPage(),transition: Transition.topLevel);
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Container(
                                margin: EdgeInsets.only(top:height * 0.01,right: width * 0.02),
                                child: Column(
                                  children: [
                                    Container(
                                      height: height * 0.1,
                                      width: width * 0.3,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*10)),
                                        image: DecorationImage(
                                          image: NetworkImage(productsController.flashSaleProductsData[index].primaryImageUrl),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 0,
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          Card(
                                            elevation: 0,
                                            color: Colors.transparent,
                                            child: Text('৳ ${productsController.flashSaleProductsData[index].price.toString()}',
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: (width/Screen.designWidth) * 25,
                                              ),
                                            )
                                          ),
                                          Card(
                                            elevation: 0,
                                            color: Colors.white,
                                            child: Text('৳ ${productsController.flashSaleProductsData[index].oldPrice.toString()}',
                                              textAlign: TextAlign.end,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.red,
                                                decoration: TextDecoration.lineThrough,
                                                fontSize: (width/Screen.designWidth) * 25,
                                              ),
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: height * 0.03,
                                      width: width* 0.3,
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          const Card(
                                            elevation : 0,
                                            color: Colors.white,
                                            child: FittedBox(
                                              child: Icon(Icons.star,color: Colors.yellow),
                                            ),
                                          ),
                                          SizedBox(width: width*0.02),
                                          Expanded(
                                            flex: 1,
                                            child: Text('${productsController.flashSaleProductsData[index].ratings.toString()} / 5',
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: (width/Screen.designWidth) * 20,
                                              ),
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}