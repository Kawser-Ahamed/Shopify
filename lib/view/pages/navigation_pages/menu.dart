import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/categories_design_data.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/utils/reusable/app_bar.dart';
import 'package:shopify/view_models/api/comments_about_shopify_view_model.dart';
import 'package:shopify/view_models/api/shopify_top_vendors_view_model.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  CategoriesDesignData categoriesDesignData = CategoriesDesignData();
  CommentsAboutShopifyViewModel commentsAboutShopifyViewModel = Get.put(CommentsAboutShopifyViewModel());
  ShopifyTopVendorsViewModel shopifyTopVendorsViewModel = Get.put(ShopifyTopVendorsViewModel());

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShopifyAppBar(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.01),
              child: Text("Our Services",
               style: GoogleFonts.aBeeZee(
                fontSize: (width/Screen.designWidth) * 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
               ),
              ),
            ),
            const Divider(),
            Container(
              height: width * 0.2,
              width: width * 1,
              color: Colors.white,
              child: ListView.builder(
                itemCount: categoriesDesignData.categoriesDesign.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: height * 0.2,
                    width: width * 0.2,
                    margin: EdgeInsets.symmetric(horizontal: width * 0.02,),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.grey,
                        width: width * 0.003,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(width * 0.02)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: AssetImage(categoriesDesignData.categoriesDesign.values.elementAt(index)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(categoriesDesignData.categoriesDesign.keys.elementAt(index),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.aBeeZee(
                              fontSize: width * 0.03,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05,vertical: height * 0.01),
                      child: Text("About Us",
                      style: GoogleFonts.aBeeZee(
                        fontSize: (width/Screen.designWidth) * 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: ExpansionTile(
                          title: Text("Customer's Comment About Shopify",
                            style: TextStyle(
                              fontSize: (width / Screen.designWidth) * 30,
                            ),
                          ),
                          collapsedBackgroundColor: Colors.white,
                          backgroundColor: Colors.white,
                          collapsedShape: RoundedRectangleBorder( 
                            borderRadius: BorderRadius.circular((width/Screen.designWidth)*10),
                          ),
                          children: [
                          FutureBuilder(
                            future: commentsAboutShopifyViewModel.getUserCommentsAboutShopify(), 
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                return  ConstrainedBox(
                                    constraints: const BoxConstraints(minHeight: 0),
                                    child: SingleChildScrollView(
                                      child: ListView.builder(
                                        physics: const RangeMaintainingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: commentsAboutShopifyViewModel.commentsAboutShopifyData.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width * 0.02,vertical: height * 0.005),
                                            child: Card(
                                              color: Colors.white,
                                              elevation: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular((width/Screen.designWidth) * 10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.shade300,
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                    ),
                                                  ]
                                                ),
                                                child: ListTile(
                                                  title: Text(snapshot.data![index].user!.username.toString(),
                                                    style: TextStyle(
                                                      fontSize: (width/Screen.designWidth) * 30,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  subtitle: Text(snapshot.data![index].body.toString(),
                                                    style: TextStyle(
                                                      fontSize: (width/Screen.designWidth) * 30,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }
                                else{
                                  return const Text("Loading...");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: ExpansionTile(
                          title: Text("Top Vendor Of Shopify",
                            style: TextStyle(
                              fontSize: (width / Screen.designWidth) * 30,
                            ),
                          ),
                          collapsedBackgroundColor: Colors.white,
                          backgroundColor: Colors.white,
                          collapsedShape: RoundedRectangleBorder( 
                            borderRadius: BorderRadius.circular((width/Screen.designWidth)*10),
                          ),
                          children: [
                          FutureBuilder(
                            future: shopifyTopVendorsViewModel.getShopifyTopVendorsList(), 
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                return  ConstrainedBox(
                                    constraints: const BoxConstraints(minHeight: 0),
                                    child: SingleChildScrollView(
                                      child: ListView.builder(
                                        physics: const RangeMaintainingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: shopifyTopVendorsViewModel.shopifyTopVendorsList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width * 0.02,vertical: height * 0.005),
                                            child: Card(
                                              color: Colors.white,
                                              elevation: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular((width/Screen.designWidth) * 10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.shade300,
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                    ),
                                                  ]
                                                ),
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundImage: NetworkImage(snapshot.data![index].image.toString()),
                                                  ),
                                                  title: Text(snapshot.data![index].firstName.toString(),
                                                    style: TextStyle(
                                                      fontSize: (width/Screen.designWidth) * 30,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  subtitle: Text(snapshot.data![index].email.toString(),
                                                    style: TextStyle(
                                                      fontSize: (width/Screen.designWidth) * 30,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }
                                else{
                                  return const Text("Loading...");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}