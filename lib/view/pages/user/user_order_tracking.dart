import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/cart_icon_design.dart';
import 'package:shopify/view_models/products/click_controller.dart';
import 'package:shopify/view_models/user/user_orders_view_model.dart';

class UserOrderTracking extends StatefulWidget {
  const UserOrderTracking({super.key});

  @override
  State<UserOrderTracking> createState() => _UserOrderTrackingState();
}

class _UserOrderTrackingState extends State<UserOrderTracking> {

  UserOrdersViewModel userOrdersViewModel = Get.find();
  ClickController clickController = Get.find();

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                  Text("Track My Order",
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
          Card(
            elevation: 0,
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.02,vertical: height * 0.02),
              decoration: BoxDecoration(
                color: AppColor.secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
              ),
              child: ListTile(
                //leading: Image.asset(AppImages.orderTracking,height: height * 0.2,width: width * 0.2,fit: BoxFit.cover,),
                trailing: Icon(Icons.favorite_outlined,color: Colors.pink,size: (width/Screen.designWidth)*60,),
                title:  Text('Order Id: ${userOrdersViewModel.userOrdersData[clickController.productIndex.value].orderId}',
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
                    Text('Reciever: ${userOrdersViewModel.userOrdersData[clickController.productIndex.value].reciever}',
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.aBeeZee(
                        fontSize: (width/Screen.designWidth) * 30,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    Text('Delivery Date: ${userOrdersViewModel.userOrdersData[clickController.productIndex.value].deliveryDate}',
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.aBeeZee(
                        fontSize: (width/Screen.designWidth) * 30,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    Text('Delivery Location: ${userOrdersViewModel.userOrdersData[clickController.productIndex.value].location}',
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.aBeeZee(
                        fontSize: (width/Screen.designWidth) * 30,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    Text('Total Price: ৳ ${userOrdersViewModel.userOrdersData[clickController.productIndex.value].grandTotalPrice}',
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.aBeeZee(
                        fontSize: (width/Screen.designWidth) * 30,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Container(
                height: height * 1,
                width: width * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade400),
                    )
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: height * 0.08,
                        left: width * 0.04,
                        right: width * 0.23,
                        bottom: height * 0.05,
                        child: Container(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Positioned(
                        top: height * 0.05,
                        bottom: height * 0.05,
                        left:width * 0.01,
                        right: 0,
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: width * 0.1,
                                    width: width * 0.1,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: (userOrdersViewModel.userOrdersData[clickController.productIndex.value].state==1) ? AppColor.primaryColor : Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon((userOrdersViewModel.userOrdersData[clickController.productIndex.value].state>=1) ? Icons.check : Icons.upcoming ,
                                      color: Colors.white,
                                      size: (width/Screen.designWidth) * 40,
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Expanded(
                                    child: Text('Ordered',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: (width/Screen.designWidth)*20,
                                        fontWeight: FontWeight.bold,
                                        color: (userOrdersViewModel.userOrdersData[clickController.productIndex.value].state>=1) ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: width * 0.1,
                                    width: width * 0.1,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: (userOrdersViewModel.userOrdersData[clickController.productIndex.value].state==2) ? AppColor.primaryColor : Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon((userOrdersViewModel.userOrdersData[clickController.productIndex.value].state>=2) ? Icons.check : Icons.upcoming ,
                                      color: Colors.white,
                                      size: (width/Screen.designWidth) * 40,
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Expanded(
                                    child: Text('Reached Out Logistic facility',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: (width/Screen.designWidth)*20,
                                        fontWeight: FontWeight.bold,
                                        color: (userOrdersViewModel.userOrdersData[clickController.productIndex.value].state>=2) ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: width * 0.1,
                                    width: width * 0.1,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: (userOrdersViewModel.userOrdersData[clickController.productIndex.value].state==3) ? AppColor.primaryColor : Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon((userOrdersViewModel.userOrdersData[clickController.productIndex.value].state>=3) ? Icons.check : Icons.upcoming,
                                      color: Colors.white,
                                      size: (width/Screen.designWidth) * 40,
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Expanded(
                                    child: Text('Shipped',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: (width/Screen.designWidth)*20,
                                        fontWeight: FontWeight.bold,
                                        color: (userOrdersViewModel.userOrdersData[clickController.productIndex.value].state>=3) ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: width * 0.1,
                                    width: width * 0.1,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: (userOrdersViewModel.userOrdersData[clickController.productIndex.value].state==4) ? AppColor.primaryColor : Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon((userOrdersViewModel.userOrdersData[clickController.productIndex.value].state>=4) ? Icons.check : Icons.upcoming,
                                      color: Colors.white,
                                      size: (width/Screen.designWidth) * 40,
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Expanded(
                                    child: Text('Ready For Collection',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: (width/Screen.designWidth)*20,
                                        fontWeight: FontWeight.bold,
                                        color: (userOrdersViewModel.userOrdersData[clickController.productIndex.value].state>=4) ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: width * 0.1,
                                    width: width * 0.1,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: (userOrdersViewModel.userOrdersData[clickController.productIndex.value].state==5) ? AppColor.primaryColor : Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon((userOrdersViewModel.userOrdersData[clickController.productIndex.value].state>=5) ? Icons.check : Icons.upcoming,
                                      color: Colors.white,
                                      size: (width/Screen.designWidth) * 40,
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Expanded(
                                    child: Text('Delivered',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: (width/Screen.designWidth)*20,
                                        fontWeight: FontWeight.bold,
                                        color: (userOrdersViewModel.userOrdersData[clickController.productIndex.value].state>=5) ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ),
                    ]
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade400),
                        left: BorderSide(color: Colors.grey.shade400),
                      )
                    ),
                    child: ListView.builder(
                      itemCount: userOrdersViewModel.userOrdersData[clickController.productIndex.value].userOrders!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0,
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                )
                              ]
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: height * 0.1,
                                  width: height * 0.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                                    image: DecorationImage(
                                      image: NetworkImage(userOrdersViewModel.userOrdersData[clickController.productIndex.value].userOrders!.elementAt(index)['productImageUrl']),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(userOrdersViewModel.userOrdersData[clickController.productIndex.value].userOrders!.elementAt(index)['name'],
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: (width/Screen.designWidth) * 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text('Total Price: ${userOrdersViewModel.userOrdersData[clickController.productIndex.value].userOrders!.elementAt(index)['totalPrice']}',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: (width/Screen.designWidth) * 30,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text('Quantity: ${userOrdersViewModel.userOrdersData[clickController.productIndex.value].userOrders!.elementAt(index)['quantity']}',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: (width/Screen.designWidth) * 30,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}