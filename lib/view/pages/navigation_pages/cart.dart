import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/view_models/cart/cart_view_model.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  CartViewModel cartViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("This is Cart"),
            Container(
              height: 200,
              width: 500,
              color: Colors.green,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartViewModel.cartproducts.length,
                itemBuilder: (context, index) {
                  final cartList = cartViewModel.cartproducts.values.toList();
                  final cartData = cartList[index];
                  return Column(
                    children: [
                      Text(cartData.productId.toString()),
                      Text(cartData.productName),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}