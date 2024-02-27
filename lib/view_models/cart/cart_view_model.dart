import 'package:get/get.dart';
import 'package:shopify/models/cart/cart_model.dart';

class CartViewModel extends GetxController{

  RxMap<int,CartModel> cartproducts = <int,CartModel>{}.obs;

  void addProductsOnCart(CartModel cartModel){
    cartproducts[cartModel.productId] = cartModel;

  }
}