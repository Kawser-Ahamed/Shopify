import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/categories_design_data.dart';
import 'package:shopify/data/navbar_controller.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/view/pages/navigation_pages/mainpage.dart';
import 'package:shopify/view/pages/products/search.dart';

class HeaderDesign extends StatelessWidget {
  const HeaderDesign({super.key});

  @override
  Widget build(BuildContext context) {
    CategoriesDesignData categoriesDesignData = CategoriesDesignData();
    NavBarController navBarController = Get.put(NavBarController());
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Column(
      children: [
        Container(
          height: height * 0.1,
          width: width * 1,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap:(){
                        Get.back();
                      },
                      child: Container(
                        height: height * 0.08,
                        width: width * 0.09,
                        color: Colors.transparent,
                        child: const FittedBox(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap:(){
                        Get.to(const Search());
                      },
                      child: Container(
                        height: height * 0.08,
                        width: width * 0.09,
                        color: Colors.transparent,
                        child: const FittedBox(
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.01),
                    InkWell(
                      onTap:(){
                        Get.back();
                      },
                      child: Container(
                        height: height * 0.08,
                        width: width * 0.09,
                        color: Colors.transparent,
                        child: const FittedBox(
                          child: Icon(
                            CupertinoIcons.cart,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.01),
                    Container(
                      height: height * 0.1,
                      width: width * 0.09,
                      color: Colors.transparent,
                      child: FittedBox(
                        child: PopupMenuButton(
                          icon: const Icon(Icons.more_vert,color: Colors.black),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: (){   
                                      navBarController.pageIndex.value = 0;                             
                                      Get.to(const MainPage());  
                                    },
                                    child: Text('Home',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: width * 0.02,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){   
                                      navBarController.pageIndex.value = 1;                             
                                      Get.to(const MainPage());  
                                    },
                                    child: Text('Profile',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: width * 0.02,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){   
                                      navBarController.pageIndex.value = 3;                             
                                      Get.to(const MainPage());  
                                    },
                                    child: Text('Settings',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: width * 0.02,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ]
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Divider(color: Colors.grey,height: height*0.02),
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
                        // height: Screen.height(context) * 0.05,
                        // width: Screen.height(context) * 0.12,
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
      ],
    );
  }
}


