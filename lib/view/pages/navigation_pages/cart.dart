import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/assets/app_images.dart';
import 'package:shopify/utils/reusable/cart_header_design.dart';
import 'package:shopify/view/pages/order/place_order.dart';
import 'package:shopify/view/pages/products/product_info_page.dart';
import 'package:shopify/view/pages/products/search.dart';
import 'package:shopify/view_models/cart/cart_view_model.dart';
import 'package:shopify/view_models/cart/cupon_view_model.dart';
import 'package:shopify/view_models/products/products_controller.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  CartViewModel cartViewModel = Get.find();
  CuponViewModel cuponViewModel = Get.put(CuponViewModel());
  ProductsController productsController = Get.find();
  TextEditingController cupon = TextEditingController();

  @override
  void initState() {
    cuponViewModel.getCuponData();
    super.initState();
  }

  @override
  void dispose() {
    cupon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.1,
              width: width * 1,
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width* 0.05),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // InkWell(
                    //   onTap:(){
                    //     //Get.back();
                    //   },
                    //   child: Icon(
                    //     Icons.explicit,
                    //     size: (width/Screen.designWidth) * 50,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    Image.asset(AppImages.appLogo,fit: BoxFit.cover,height: height * 0.07,width: height * 0.07),
                    Text("Shopify Cart",
                      style: GoogleFonts.aBeeZee(
                        fontSize: (width/Screen.designWidth) * 40,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    InkWell(
                      onTap:(){
                        Get.to(const Search(),transition: Transition.rightToLeftWithFade);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: height * 0.01),
                        child: Icon(
                          Icons.search,
                          size: (width/Screen.designWidth) * 70,
                          color: Colors.black,
                        ),
                      ),
                    ), 
                  ],
                ),
              ),
            ),
            (cartViewModel.cartProducts.isEmpty) ? Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(AppImages.emptyCart,height: height * 0.5,width: width * 1),
                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Text("OH! Dear. You didn't add anything into cart.Hurry up buy something from shopify.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.actor(
                        fontSize: (width/Screen.designWidth) * 35,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  )
                ],
              )
            ) : Expanded(
              child: Column(
                children: [
                  const CartHeaderDesign(animationWidth: 4),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Obx(() => ListView.builder(
                            shrinkWrap: true,
                            itemCount: cartViewModel.cartProducts.length,
                            physics: const RangeMaintainingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final cartDataList = cartViewModel.cartProducts.values.toList();
                              final cartProductData = cartDataList[index];
                              return InkWell(
                                onTap:(){
                                  productsController.filterProductInfo(cartViewModel.cartProducts.keys.elementAt(index));
                                  Get.to(const ProductInfoPage(),transition: Transition.topLevel);
                                },
                                child: Card(
                                  elevation: 0.0,
                                  color: Colors.white,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: (width * 0.01)),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                        )
                                      ]
                                    ),
                                    child: Row(
                                      children: [
                                      Container(
                                        height: height * 0.12,
                                        width: height * 0.12,
                                        margin: EdgeInsets.all((width/Screen.designWidth)*5),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)* 20)),
                                          image: DecorationImage(
                                            image: NetworkImage(cartProductData.productImageUrl),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(cartProductData.productName,
                                                    style: GoogleFonts.aBeeZee(
                                                      fontSize: (width/Screen.designWidth) * 30,
                                                      fontWeight: FontWeight.bold,
                                                    ),       
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                    onTap: (){
                                                      cartViewModel.deleteProduct(cartProductData.productId);
                                                    },
                                                    child: Container(
                                                      height: height * 0.05,
                                                      width: height * 0.05,
                                                      decoration: const BoxDecoration(
                                                        color: Colors.pink,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: FittedBox(
                                                        child: Padding(
                                                          padding: EdgeInsets.all((width/Screen.designWidth)*5),
                                                          child: const Icon(Icons.delete_outline,color: Colors.white,)
                                                        ),
                                                      )
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Price : ${cartProductData.price.toString()}',
                                                        style: GoogleFonts.aBeeZee(
                                                          fontSize: (width/Screen.designWidth) * 30,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      // GetBuilder<CartViewModel>(
                                                      //   builder: (cartViewModel) {
                                                      //     return Text("Total Price: ${cartProductData.totalPrice.toString()}",
                                                      //       style: GoogleFonts.aBeeZee(
                                                      //         fontSize: (width/Screen.designWidth) * 30,
                                                      //         fontWeight: FontWeight.w500,
                                                      //       ),
                                                      //     );
                                                      //   },
                                                      // ),
                                                      (cartProductData.size.isNotEmpty) ? Text('Size : ${cartProductData.size}',
                                                        style: GoogleFonts.aBeeZee(
                                                          fontSize: (width/Screen.designWidth) * 30,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ) : const SizedBox(),
                                                    ],
                                                  )
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: height * 0.05,
                                                    width: width * 0.2,
                                                    color: Colors.transparent,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(right: width * 0.03),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          InkWell(
                                                            onTap: (){
                                                              if(cartProductData.quantity>1){
                                                                cartViewModel.decreaseQuantity(index);
                                                              }
                                                            },
                                                            child: Icon(Icons.remove,color: Colors.red,size: (width/Screen.designWidth)*50)
                                                          ),
                                                          SizedBox(width: width * 0.02),
                                                          GetBuilder<CartViewModel>(
                                                            builder: (cartViewModel) {
                                                              return Text(cartProductData.quantity.toString(),
                                                                style: GoogleFonts.aBeeZee(
                                                                  fontSize: (width/Screen.designWidth) * 30,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                          SizedBox(width: width * 0.02),
                                                          InkWell(
                                                            onTap: (){
                                                              if(cartProductData.quantity < cartProductData.originalQuantity){
                                                                cartViewModel.increaseQuantity(index);
                                                              }
                                                              else{
                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: const Duration(seconds: 1), content: Column(children: [
                                                                  Text("Shopify",
                                                                    style: GoogleFonts.aBeeZee(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: (width/Screen.designWidth) * 30,
                                                                    ),
                                                                  ),
                                                                  Text("Sorry, We don't have much product than that",
                                                                    style: GoogleFonts.aBeeZee(
                                                                      fontWeight: FontWeight.normal,
                                                                      fontSize: (width/Screen.designWidth) * 25,
                                                                    ),
                                                                  ),
                                                                ],),));
                                                              }
                                                            },
                                                            child: Icon(Icons.add,color: Colors.green,size: (width/Screen.designWidth)*50)),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),),
                          Container(
                            height: height * 0.06,
                            width: width * 1,
                            margin: EdgeInsets.symmetric(horizontal: width * 0.02,vertical: height * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*10)),
                              boxShadow: const[
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                )
                              ]
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: width* 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: height * 0.03,
                                    color: Colors.transparent,
                                    child: FittedBox(
                                      child: Text("Have a discount cupon?",
                                        style: TextStyle(
                                          fontSize: (width/Screen.designWidth) * 40,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: (){
                                      showDialog(
                                        context: context, 
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: Container(
                                              height: height * 0.05,
                                              width: width * 0.05,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                image: DecorationImage(
                                                  image: AssetImage(AppImages.cupon)
                                                ),
                                              ),
                                            ),
                                            content: TextField(
                                              controller: cupon,
                                              decoration: const InputDecoration(
                                                prefixIcon: Icon(Icons.local_offer_outlined),
                                                hintText: 'Enter cupon name',
                                                focusColor: Colors.black,
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.black)
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.black)
                                                )
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                }, 
                                                child: Text("Cancel",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: (width/Screen.designWidth) *30,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: (){
                                                  cuponViewModel.cuponDiscount(cupon.text).whenComplete((){
                                                    cartViewModel.cuponDiscount();
                                                  });
                                                  //cupon.text="";
                                                  Navigator.pop(context);
                                                }, 
                                                child: Text("Apply",
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: (width/Screen.designWidth) *30,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );        
                                    }, 
                                    child: SizedBox(
                                      height: height * 0.03,
                                      child: FittedBox(
                                        child: Text("Apply",
                                          style: TextStyle(
                                            fontSize: (width/Screen.designWidth) * 30,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 0.0,
                            color: Colors.white,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                  )
                                ]
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.01),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: height * 0.05,
                                      color: Colors.transparent,
                                      child: FittedBox(
                                        child: Text("Order Summary",
                                          style: TextStyle(
                                            fontSize: (width/Screen.designWidth) * 40,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(color: Colors.grey,thickness: height * 0.002),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: height * 0.04,
                                          color: Colors.transparent,
                                          child: FittedBox(
                                            child: Text("Subtotal:",
                                              style: TextStyle(
                                                fontSize: (width/Screen.designWidth) * 40,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: height * 0.04,
                                          color: Colors.transparent,
                                          child: FittedBox(
                                            child: Obx(() => Text('৳ ${cartViewModel.totalPrice.toString()}',
                                              style: TextStyle(
                                                fontSize: (width/Screen.designWidth) * 40,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: height * 0.04,
                                          color: Colors.transparent,
                                          child: FittedBox(
                                            child: Text("Delivery:",
                                              style: TextStyle(
                                                fontSize: (width/Screen.designWidth) * 40,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: height * 0.04,
                                          color: Colors.transparent,
                                          child: FittedBox(
                                            child: Obx(() => Text('৳ ${cartViewModel.deliveryChargePrice.toString()}',
                                              style: TextStyle(
                                                fontSize: (width/Screen.designWidth) * 40,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: height * 0.04,
                                          color: Colors.transparent,
                                          child: FittedBox(
                                            child: Text("Discount:",
                                              style: TextStyle(
                                                fontSize: (width/Screen.designWidth) * 40,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: height * 0.04,
                                          color: Colors.transparent,
                                          child: FittedBox(
                                            child: Obx(() => Text('৳ ${cuponViewModel.totalDiscountPrice.toString()}',
                                              style: TextStyle(
                                                fontSize: (width/Screen.designWidth) * 40,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),)
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(color: Colors.grey,thickness: height * 0.002),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: height * 0.04,
                                          color: Colors.transparent,
                                          child: FittedBox(
                                            child: Text("Grand Total:",
                                              style: TextStyle(
                                                fontSize: (width/Screen.designWidth) * 40,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: height * 0.04,
                                          color: Colors.transparent,
                                          child: FittedBox(
                                            child: Obx(() => Text('৳ ${cartViewModel.grandTotalPrice.toString()}',
                                              style: TextStyle(
                                                fontSize: (width/Screen.designWidth) * 40,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.05),
                          InkWell(
                            onTap:(){
                              Get.to(const PlaceOrder(),transition: Transition.rightToLeftWithFade);
                            },
                            child: Container(
                              height: height * 0.08,
                              width: width * 1,
                              margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                                gradient: const LinearGradient(colors: [Colors.pink,Colors.red]),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: FittedBox(
                                      child: Padding(
                                        padding: EdgeInsets.all((width/Screen.designWidth)*30),
                                        child: Image.asset(AppImages.orderNow),
                                      ),
                                    )
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: FittedBox(
                                      child: Padding(
                                        padding: EdgeInsets.all((width/Screen.designWidth)*20),
                                        child: Text("Place Order Now",
                                        style: TextStyle(
                                          fontSize: (width/Screen.designWidth)*30,
                                          color: Colors.white
                                        ),
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.05),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}