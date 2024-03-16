import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/models/cart/cart_model.dart';
import 'package:shopify/view_models/cart/cupon_view_model.dart';

class CartViewModel extends GetxController{

  CuponViewModel cuponViewModel = Get.put(CuponViewModel());
  RxMap<int,CartModel> cartProducts = <int,CartModel>{}.obs;
  RxDouble totalPrice = 0.0.obs;
  RxDouble deliveryChargePrice = 0.0.obs;
  RxDouble grandTotalPrice = 0.0.obs;
  RxString deliverDate = "".obs;
  RxString deliveryLocation = "".obs;
  TextEditingController location = TextEditingController();

  void addProductsOnCart(CartModel cartModel){
    cartProducts[cartModel.productId] = cartModel;
    totalPrice.value = 0.0;
    deliveryChargePrice.value = 0.0;
    for(MapEntry<int,CartModel> entry in cartProducts.entries){
      totalPrice.value += entry.value.totalPrice.toDouble();
      deliveryChargePrice.value += entry.value.deliveryCharge;
    }
    grandTotalPrice.value = (deliveryChargePrice.value+totalPrice.value);
    cuponDiscount();
  }

  void deleteProduct(int productId){
    cartProducts.remove(productId);
    totalPrice.value = 0.0;
    deliveryChargePrice.value = 0.0;
    for(MapEntry<int,CartModel> entry in cartProducts.entries){
      totalPrice.value += entry.value.totalPrice.toDouble();
      deliveryChargePrice.value += entry.value.deliveryCharge;
    }
    grandTotalPrice.value = (deliveryChargePrice.value+totalPrice.value);
    cuponDiscount();
  }

  void decreaseQuantity(int index){
    cartProducts.values.elementAt(index).quantity--;
    cartProducts.values.elementAt(index).totalPrice  = cartProducts.values.elementAt(index).price * cartProducts.values.elementAt(index).quantity;
    totalPrice.value = 0.0;
    for(MapEntry<int,CartModel> entry in cartProducts.entries){
      totalPrice.value += entry.value.totalPrice.toDouble();
    }
    grandTotalPrice.value =(deliveryChargePrice.value+totalPrice.value);
    cuponDiscount();
    update();
  }

  void increaseQuantity(int index){
    cartProducts.values.elementAt(index).quantity++;
    cartProducts.values.elementAt(index).totalPrice  = cartProducts.values.elementAt(index).price * cartProducts.values.elementAt(index).quantity;
    totalPrice.value = 0.0;
    for(MapEntry<int,CartModel> entry in cartProducts.entries){
      totalPrice.value += entry.value.totalPrice.toDouble();
    }
    grandTotalPrice.value =(deliveryChargePrice.value+totalPrice.value);
    cuponDiscount();
    update();
  }

  void cuponDiscount(){
    if(cuponViewModel.discountPrice.value!=0){
      grandTotalPrice.value = (deliveryChargePrice.value + totalPrice.value);
      cuponViewModel.totalDiscountPrice.value = (grandTotalPrice.value * cuponViewModel.discountPrice.value) / 100.0;
      grandTotalPrice.value -= cuponViewModel.totalDiscountPrice.value;
    }
  }
}