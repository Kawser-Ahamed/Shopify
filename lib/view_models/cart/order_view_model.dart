import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/models/cart/cart_model.dart';
import 'package:shopify/resource/assets/app_images.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/loading.dart';
import 'package:shopify/view/pages/navigation_pages/mainpage.dart';
import 'package:shopify/view_models/cart/cart_view_model.dart';
import 'package:shopify/view_models/user/user_information_view_model.dart';

class OrderViewModel{

  CartViewModel cartViewModel = Get.find();
  ShopifyUserInformationViewModel shopifyUserInformationViewModel = Get.find();

  Future<void> order(BuildContext context,double height,double width) async{
    try{
      showDialog(
        barrierDismissible: false,
        context: context, 
        builder: (context) {
          return Center(
            child: Loading(color: AppColor.primaryColor, size: 0.05),
          );
        },
      ); 
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      List<CartModel> testList = cartViewModel.cartProducts.values.toList();
      FirebaseFirestore.instance.collection('${sharedPreferences.getString('email').toString()}-Orders').add({
        'products' : testList.map((e)=>{
         'name' : e.productName,
         'price' : e.price,
         'size' : e.size,
         'quantity' : e.quantity,
         'deliveryCharge' : e.deliveryCharge,
         'productImageUrl' : e.productImageUrl,
         'totalPrice' : e.totalPrice,
        }).toList(),
        'status' : "Ordered",
        'orderId' : DateTime.now().microsecondsSinceEpoch,
        'reciever' : shopifyUserInformationViewModel.userInformation.first.name,
        'grandTotalPrice' : cartViewModel.grandTotalPrice.toDouble(),
        'deliveryDate' : cartViewModel.deliverDate.toString(),
        'state' : 1,
        'location' : (cartViewModel.location.text.isEmpty) ? shopifyUserInformationViewModel.userInformation.first.location.toString() : cartViewModel.location.text.toString(),
      }).then((value){
        debugPrint('success');
        int previousPoint = shopifyUserInformationViewModel.userInformation.first.points;
        previousPoint += ((cartViewModel.grandTotalPrice.value * 2)~/100.0).toInt();
        FirebaseFirestore.instance.collection(sharedPreferences.getString('email').toString()).doc('Shopify-User-Information').update({
          'points' : previousPoint,
        }).then((value){
          Navigator.pop(context);
          Get.to(const MainPage());
          showDialog(
            barrierDismissible: true,
            barrierColor: Colors.transparent,
            context: context, 
            builder: (context) {
              return AlertDialog(
                backgroundColor: AppColor.successBackground,
                content: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: height * 0.4,
                      child: Image.asset(AppImages.success),
                    ),
                      Positioned(
                      top: height * 0.2,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: Text("Congratulation!!!.Your order successfully complete.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.aBeeZee(
                              fontSize: (width/Screen.designWidth) * 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      )
                    ),
                    Image.asset(AppImages.congratulation,fit: BoxFit.fill),
                  ],
                ),
              );
            },
          );
        });
      });
      cartViewModel.cartProducts.clear();
      cartViewModel.deliverDate.value = "";
    }
    catch(error){
      debugPrint(error.toString());
    }
  }
}