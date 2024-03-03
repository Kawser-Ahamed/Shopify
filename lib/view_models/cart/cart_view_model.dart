import 'package:get/get.dart';
import 'package:shopify/models/cart/cart_model.dart';

class CartViewModel extends GetxController{

  RxMap<int,CartModel> cartProducts = <int,CartModel>{}.obs;
  RxDouble totalPrice = 0.0.obs;
  RxDouble deliveryChargePrice = 0.0.obs;

  void addProductsOnCart(CartModel cartModel){
    cartProducts[cartModel.productId] = cartModel;
    totalPrice.value = 0.0;
    deliveryChargePrice.value = 0.0;
    for(MapEntry<int,CartModel> entry in cartProducts.entries){
      totalPrice.value += entry.value.totalPrice.toDouble();
      deliveryChargePrice.value += entry.value.deliveryCharge;
    }
  }

  void decreaseQuantity(int index){
    cartProducts.values.elementAt(index).quantity--;
    cartProducts.values.elementAt(index).totalPrice  = cartProducts.values.elementAt(index).price * cartProducts.values.elementAt(index).quantity;
    totalPrice.value = 0.0;
    for(MapEntry<int,CartModel> entry in cartProducts.entries){
      totalPrice.value += entry.value.totalPrice.toDouble();
    }
    update();
  }

  void increaseQuantity(int index){
    cartProducts.values.elementAt(index).quantity++;
    cartProducts.values.elementAt(index).totalPrice  = cartProducts.values.elementAt(index).price * cartProducts.values.elementAt(index).quantity;
    totalPrice.value = 0.0;
    for(MapEntry<int,CartModel> entry in cartProducts.entries){
      totalPrice.value += entry.value.totalPrice.toDouble();
    }
    update();
  }
}