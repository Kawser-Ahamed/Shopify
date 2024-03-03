import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/view/pages/navigation_pages/cart.dart';
import 'package:shopify/view_models/cart/cart_view_model.dart';

class CartIconsDesign extends StatefulWidget {
  final double iconsHeight;
  final double iconWidth;
  final Color color;
  const CartIconsDesign({super.key, required this.iconsHeight, required this.iconWidth, required this.color});

  @override
  State<CartIconsDesign> createState() => _CartIconsDesignState();
}

class _CartIconsDesignState extends State<CartIconsDesign> {
  CartViewModel cartViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Container(
      height: height * (widget.iconsHeight),
      width: height * (widget.iconsHeight),
      color: Colors.transparent,
      child: Stack(
        children: [
          IconButton(
            onPressed: (){
              Get.to(const Cart(),transition: Transition.leftToRightWithFade);
            }, 
            icon: FittedBox(
              child: Icon(
                CupertinoIcons.cart,
                size: (width/Screen.designWidth) * 60,
                color: widget.color,
              ),
            ),
          ),
          Obx((){
            if (cartViewModel.cartProducts.isNotEmpty){
              return Positioned(
                top: 0,
                bottom: height * ((widget.iconsHeight)/2),
                left: height *((widget.iconsHeight)/2),
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                  child: FittedBox(
                    child:Text(cartViewModel.cartProducts.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              );
            }
            else{
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }
}