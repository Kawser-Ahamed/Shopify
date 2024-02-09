import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/loading.dart';
import 'package:shopify/view/pages/products/brand_products.dart';
import 'package:shopify/view_models/products/categories_controller.dart';
import 'package:shopify/view_models/products/click_controller.dart';
import 'package:shopify/view_models/products/products_controller.dart';
import 'package:shopify/view_models/products/sub_category_controller.dart';
import 'package:shopify/view_models/products/sub_category_products_controller.dart';

class CategoriesSideBar extends StatefulWidget {
  const CategoriesSideBar({super.key});

  @override
  State<CategoriesSideBar> createState() => _CategoriesSideBarState();
}

class _CategoriesSideBarState extends State<CategoriesSideBar> {

  CategoriesController categoriesController = Get.find();
  ProductsController productsController = Get.find();
  ClickController clickController = Get.put(ClickController());
  SubCategoryController subCategoryController = Get.put(SubCategoryController());
  SubCategoryProductsController subCategoryProductsController = Get.put(SubCategoryProductsController());

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              border: BorderDirectional(end: BorderSide(color: Colors.grey.withOpacity(0.5),width: width * 0.004))
            ),
            child: FutureBuilder(
              future: categoriesController.getShopifyCategories(), 
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: Loading(color: AppColor.primaryColor, size: 0.08));
                }
                else if(snapshot.hasError){
                  return Center(child: Loading(color: AppColor.primaryColor, size: 0.08));
                }
                else{
                  return ListView.builder(
                    itemCount: categoriesController.categoriesData.length,
                    itemBuilder: (context, index) {
                      return Obx((){
                        return InkWell(
                        onTap: (){
                          clickController.clickIndex.value = index;
                        },
                        child: Container(
                          height: height * 0.16,
                          width: width * 1,
                          color: (clickController.clickIndex.value == index) ? AppColor.primaryColor : Colors.transparent,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: width * 0.01,vertical: width * 0.01),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    image: DecorationImage(
                                      image: NetworkImage(categoriesController.categoriesData[index].imageUrl),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child:Text(categoriesController.categoriesData[index].name,
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                    fontSize: (width>=600) ? width* 0.025 :width * 0.03,
                                   ),
                                )
                              )
                            ],
                          ),
                        ),
                      );
                      });
                    },
                  );
                }
              },
            ),
          )
        ),   
        Expanded(
          flex:3,
          child: Obx((){
            return Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: height * 1,
                      alignment: Alignment.topCenter,
                      child: FutureBuilder(
                        future: subCategoryController.getSubCategoryData(categoriesController.categoriesData[clickController.clickIndex.value].name), 
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(child: Loading(color: AppColor.primaryColor, size: 0.08));
                          }
                          else if(snapshot.hasError){
                            return Center(child: Loading(color: AppColor.primaryColor, size: 0.08));
                          }
                          else{
                            return ExpandedTileList.builder(
                              maxOpened: 1,
                              itemCount: subCategoryController.subCategoryData.length, 
                              itemBuilder: (context, index, controller) {
                                return ExpandedTile(
                                  title: Text(subCategoryController.subCategoryData[index].name), 
                                  theme: const ExpandedTileThemeData(
                                    contentBackgroundColor: Colors.white,
                                    contentRadius: 0,
                                  ),
                                  controller: controller.copyWith(isExpanded: true),
                                  content: Obx((){
                                    return ConstrainedBox(
                                      constraints: const BoxConstraints(minHeight: 0),
                                      child: FutureBuilder(
                                        future: subCategoryProductsController.getSubCategoryProducts(subCategoryController.subCategoryData[index].name), 
                                        builder: (context, snapshot) {
                                          if(snapshot.connectionState == ConnectionState.waiting){
                                            return Center(child: Loading(color: AppColor.primaryColor, size: 0.04));
                                          }
                                          else if(snapshot.hasError){
                                            return Center(child: Loading(color: AppColor.primaryColor, size: 0.04));
                                          }
                                          else{
                                            return GridView.builder(
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 1,
                                                mainAxisSpacing: 1,
                                              ), 
                                              itemCount: subCategoryProductsController.subCategoryProductsData.length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              physics: const RangeMaintainingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: (){
                                                    clickController.productId.value = subCategoryProductsController.subCategoryProductsData[index].id;
                                                    clickController.brand.value = subCategoryProductsController.subCategoryProductsData[index].name;
                                                    clickController.brandImage.value = subCategoryProductsController.subCategoryProductsData[index].imageUrl;
                                                    productsController.filterSubCategoryProducts(clickController.brand.value);
                                                    Get.to(const BrandProducts());
                                                  },
                                                  child: Hero(
                                                    tag: subCategoryProductsController.subCategoryProductsData[index].id,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                                                            decoration: BoxDecoration(
                                                              color: Colors.transparent,
                                                              image: DecorationImage(
                                                                image: NetworkImage(subCategoryProductsController.subCategoryProductsData[index].imageUrl),
                                                                //fit: BoxFit.cover,
                                                              )
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            subCategoryProductsController.subCategoryProductsData[index].name,
                                                            textAlign: TextAlign.center,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: GoogleFonts.aBeeZee(
                                                              fontSize: (width/Screen.designWidth) * 15,
                                                            ),
                                                          )
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                      )
                                    );
                                  }),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            );
          })
        )
      ],
    );
  }
}