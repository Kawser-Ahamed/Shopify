import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/assets/app_images.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/cart_header_design.dart';
import 'package:shopify/utils/reusable/names.dart';
import 'package:shopify/view/pages/products/search.dart';
import 'package:shopify/view_models/cart/cart_view_model.dart';
import 'package:shopify/view_models/cart/order_view_model.dart';
import 'package:shopify/view_models/user/user_information_view_model.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {

  CartViewModel cartViewModel = Get.find();
  ShopifyUserInformationViewModel shopifyUserInformationViewModel = Get.find();
  OrderViewModel orderViewModel = Get.put(OrderViewModel());

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
            color: Colors.transparent,
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
                    icon: Icon(Icons.arrow_back_ios_new,size: (width/Screen.designWidth)*50),
                  ),
                  Text("Place Order",
                    style: GoogleFonts.aBeeZee(
                      fontSize: (width/Screen.designWidth) * 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      Get.to(const Search(),transition: Transition.rightToLeftWithFade);
                    }, 
                    icon: Icon(Icons.search,size: (width/Screen.designWidth)*50),
                  ),
                ],
              ),
            ),
          ),
          const CartHeaderDesign(animationWidth: 2),
          Container(
            height: height * 0.15,
            width: width * 1,
            margin: EdgeInsets.symmetric(horizontal: width * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2,
                  blurRadius: 2,
                ),
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: width * 0.03,),
                Expanded(
                  flex: 1,
                  child: Image.asset(AppImages.placeOrder),
                ),
                SizedBox(width: width * 0.05,),
                Expanded(
                  flex: 2,
                  child: Text("Products on your door.",
                    style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                      fontSize: (width/Screen.designWidth) * 30,
                    ),
                  )
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text('Date & Location', 
                          style: TextStyle(
                            fontSize: (width/Screen.designWidth) * 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text('Please choose your appropriate date & location for recieve products.', 
                          style: TextStyle(
                            fontSize: (width/Screen.designWidth) * 30,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                TextButton(
                                  onPressed: (){
                                
                                  },
                                  child: Text('Please Choose Date', 
                                    style: TextStyle(
                                      fontSize: (width/Screen.designWidth) * 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: ()async{
                                    DateTime? dateTime = await showDatePicker(
                                      context: context, 
                                      firstDate: DateTime(2020), 
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime(2030),
                                      barrierDismissible: false,
                                    );
                                    if(dateTime!=null){
                                      cartViewModel.deliverDate.value = dateTime.toString().split(" ")[0];
                                    }
                                  }, 
                                  icon: Icon(Icons.calendar_month_outlined,size: (width/Screen.designWidth)*60,color: AppColor.secondaryColor)
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.03,bottom: height * 0.02),
                                  child: Text('Choosen Date:',
                                    style: TextStyle(
                                      fontSize: (width/Screen.designWidth)*30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: width * 0.05),
                                Obx((){
                                  if(cartViewModel.deliverDate.value.isEmpty){
                                    return Text('No date Choosen',
                                      style: TextStyle(
                                        fontSize: (width/Screen.designWidth)*30,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.red,
                                      ),
                                    );
                                  }
                                  else{
                                    return  Text(cartViewModel.deliverDate.value,
                                      style: TextStyle(
                                        fontSize: (width/Screen.designWidth)*30,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.green,
                                      ),
                                    );
                                  }
                                }),
                              ],
                            )
                          ],
                        ),
                      )
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    child:Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.03,),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.05,vertical: height * 0.02),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Current Location: ',
                                  style: TextStyle(
                                    fontSize: (width/Screen.designWidth)*30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: width * 0.05),
                                (shopifyUserInformationViewModel.userInformation.first.location!.isEmpty)?Expanded(
                                  child: Text('No Location Choosen',
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: (width/Screen.designWidth)*30,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.red,
                                    ),
                                  ),
                                ) : Expanded(
                                  child: Text(shopifyUserInformationViewModel.userInformation.first.location.toString(),
                                    style: TextStyle(
                                      fontSize: (width/Screen.designWidth)*30,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: height * 0.002,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text("OR",
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: (width/Screen.designWidth) * 30,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: height * 0.002,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.01),
                            child: TextFormField(
                              controller: cartViewModel.location,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.map_sharp,color: AppColor.iconBackground,size: (width/Screen.designWidth)*50),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  )
                                ),
                                hintText: 'Enter delivery location manually',
                                hintMaxLines: 1,
                                hintStyle: TextStyle(
                                  fontSize: (width/Screen.designWidth)*30,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  )
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.02),
                    child: Text("${Names.appName} delivery boy will hand over your products on your door on time. Thanks for being with us.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: (width/Screen.designWidth) * 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap:(){
                      if(cartViewModel.deliverDate.value.isEmpty){
                        showDialog(
                          barrierDismissible: true,
                          context: context, 
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Icon(Icons.clear,size: (width/Screen.designWidth)*100,color: Colors.red,),
                              content: Text("Please choose a valid date. So that we can deliver your product to you.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: (width/Screen.designWidth)*30,
                                  color: Colors.black,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }, 
                                  child: Text("OK",
                                    style: TextStyle(
                                      fontSize: (width/Screen.designWidth)*40,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      else if(cartViewModel.location.text.isEmpty && shopifyUserInformationViewModel.userInformation.first.location!.isEmpty){
                        showDialog(
                          barrierDismissible: true,
                          context: context, 
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Icon(Icons.clear,size: (width/Screen.designWidth)*100,color: Colors.red,),
                              content: Text("Please choose a valid address. So that we can deliver your product to you.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: (width/Screen.designWidth)*30,
                                  color: Colors.black,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }, 
                                  child: Text("OK",
                                    style: TextStyle(
                                      fontSize: (width/Screen.designWidth)*40,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      else{
                        orderViewModel.order(context,height,width);
                      }
                    },
                    child: Container(
                      height: height * 0.08,
                      width: width * 1,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                        gradient: const LinearGradient(colors: [Colors.pink,Colors.red]),
                      ),
                      alignment: Alignment.center,
                      child:Text("Order Now",
                        style: TextStyle(
                          fontSize: (width/Screen.designWidth)*40,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                ],
              ),
            ),
          )
        ]
      ), 
    );
  }
}