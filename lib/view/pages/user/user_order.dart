import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/assets/app_images.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/cart_icon_design.dart';
import 'package:shopify/utils/reusable/loading.dart';
import 'package:shopify/view/pages/user/user_order_tracking.dart';
import 'package:shopify/view_models/products/click_controller.dart';
import 'package:shopify/view_models/user/user_information_view_model.dart';
import 'package:shopify/view_models/user/user_orders_view_model.dart';

class UserOrder extends StatefulWidget {
  const UserOrder({super.key});

  @override
  State<UserOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {

  ShopifyUserInformationViewModel shopifyUserInformationViewModel = Get.find();
  UserOrdersViewModel userOrdersViewModel = Get.put(UserOrdersViewModel());
  ClickController clickController = Get.find();

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * 0.1,
            width: width * 1,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: (){
                      Get.back();
                    },
                     icon: Icon(Icons.arrow_back_ios_new,size:(width/Screen.designWidth)*60,color: Colors.black,),
                  ),
                  Text("My Orders",
                    style: TextStyle(
                    fontSize: (width/Screen.designWidth) * 40,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  const CartIconsDesign(iconsHeight: 0.07, iconWidth: 0.07, color: Colors.black),
                ]
              ),
            ),
          ),
          SizedBox(height: height * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Text('HEY, ${shopifyUserInformationViewModel.userInformation.first.name}!',
              textAlign: TextAlign.start,
              style: GoogleFonts.aBeeZee(
                fontSize: (width/Screen.designWidth) * 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Text("Thank you for your order.We'll happy to see you again.we hope our journy will be fantastic!",
              textAlign: TextAlign.start,
              style: GoogleFonts.aBeeZee(
                fontSize: (width/Screen.designWidth) * 30,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          Card(
            elevation: 0,
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width* 0.03,vertical: height * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 2,
                    spreadRadius: 2
                  ),
                ]
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(AppImages.cashOnDelivery,height: height * 0.15,width: width * 0.5,),
                  ),
                  Expanded(
                    child: Text("We provide cash on delivery.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aBeeZee(
                        fontSize: (width/Screen.designWidth) * 35,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.03),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: width * 1,
              margin: EdgeInsets.symmetric(horizontal: width * 0.03),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular((width/Screen.designWidth)*20),
                  topRight: Radius.circular((width/Screen.designWidth)*20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 2,
                    spreadRadius: 2
                  ),
                ]
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.012),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Summary',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.aBeeZee(
                        fontSize: (width/Screen.designWidth) * 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Expanded(
                      child: FutureBuilder(
                        future: userOrdersViewModel.getUserOrders(), 
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return ListView.builder(
                              itemCount: userOrdersViewModel.userOrdersData.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap:(){
                                    clickController.productIndex.value = index;
                                    Get.to(const UserOrderTracking(),transition: Transition.rightToLeftWithFade);
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color:Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                                        border: Border.all(color: Colors.grey.shade400), 
                                      ),
                                      child: ListTile(
                                        leading: Image.asset((index%2==0) ? AppImages.freeProduct : AppImages.truckProduct,height: height * 0.1,width: width * 0.2,),
                                        title: Text('Order Id: ${snapshot.data![index].orderId}',
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.aBeeZee(
                                            fontSize: (width/Screen.designWidth) * 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Reciever: ${snapshot.data![index].reciever}',
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: (width/Screen.designWidth) * 25,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text('Delivery Date: ${snapshot.data![index].deliveryDate}',
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: (width/Screen.designWidth) * 25,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text('Total Price: ৳${snapshot.data![index].grandTotalPrice}',
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: (width/Screen.designWidth) * 25,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          else{
                            return Center(child: Loading(color: AppColor.primaryColor, size: 0.08));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}