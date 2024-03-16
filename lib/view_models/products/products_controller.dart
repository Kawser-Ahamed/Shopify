import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/models/products/products_model.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/view_models/products/click_controller.dart';

class ProductsController extends GetxController{

  RxList<ProductsModel> flashSaleProductsData = <ProductsModel>[].obs;
  RxList<ProductsModel> productsData = <ProductsModel>[].obs;
  List<ProductsModel> categoryProducts = <ProductsModel>[];
  List<ProductsModel> productInfoCatgory = <ProductsModel>[];
  List<ProductsModel> filterProducts = <ProductsModel>[];
  List<ProductsModel> subCategoryProducts = <ProductsModel>[];
  ClickController clickController = Get.put(ClickController());
  List<ProductsModel> productInfoData = <ProductsModel>[];

  Future<List<ProductsModel>> getFlashSaleProducts() async{
    try{
      QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("Flash Sale").get();
      flashSaleProductsData.value = querySnapshot.docs.map((DocumentSnapshot<Map<String,dynamic>> doc) => ProductsModel(
        id: doc['id'], 
        productName: doc['productName'], 
        price: doc['price'],
        primaryImageUrl: doc['primaryImageUrl'],
        category: doc.data()!.containsKey('category') ? doc['category'] : "",
        ratings: doc['ratings'],
        brandName: doc['brandName'],
        quantity: doc['quantity'],
        productDescription: doc['productDescription'],
        type: doc['type'],
        productSize: List<String>.from(doc.data()!.containsKey('size') ? doc['size'] : []),
        deliveryCharge: doc.data()!.containsKey('deliverCharge') ? doc['deliveryCharge'] : 0,
        oldPrice: doc.data()!.containsKey('oldPrice') ? doc['oldPrice'] : 0,
      )).toList();
      update();
      return flashSaleProductsData;
    }
    catch(error){
      debugPrint(error.toString());
    }
    return flashSaleProductsData;
  }

  Future<List<ProductsModel>> getProducts() async{
    try{
      QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("Products").get();
      productsData.value = querySnapshot.docs.map((DocumentSnapshot<Map<String,dynamic>> doc) => ProductsModel(
        id: doc['id'], 
        productName: doc['productName'], 
        price: doc['price'], 
        primaryImageUrl: doc['primaryImageUrl'],
        category: doc['category'],
        ratings: doc['ratings'],
        brandName: doc['brandName'],
        quantity: doc['quantity'],
        productDescription: doc['productDescription'],
        productSize: List<String>.from(doc.data()!.containsKey('size') ? doc['size'] : []),
        type: doc['type'],
        oldPrice: doc.data()!.containsKey('oldPrice') ? doc['oldPrice'] : 0,
        deliveryCharge: doc.data()!.containsKey('deliveryCharge') ? doc['deliveryCharge'] : 0,
      )).toList();
      update();
      return productsData;
    }
    catch(error){
      debugPrint(error.toString());
    }
    return productsData;
  }

  void searchFilter(String searchName,double lowerPrice,double highPrice,double ratings){
    if(searchName.isNotEmpty){
      filterProducts.clear();
      filterProducts = productsData.where((product)=>
      (product.productName.toLowerCase().contains(searchName.toLowerCase()) || product.category.toLowerCase().contains(searchName.toLowerCase())) 
       && (product.price >= lowerPrice && product.price <= highPrice) && (product.ratings >= ratings)
      )
      .toList();
    }
    else{
      Get.snackbar("Shopify", "Please enter products name",
        backgroundColor: AppColor.primaryColor,
        colorText: Colors.white,
      );
    }
  }

  void filterCategoryProducts(String category){
    categoryProducts.clear();
    categoryProducts = productsData.where((product) => (product.category == category)).toList();
  }

  void filterProductInfoCategoryProducts(String category,int id){
    productInfoCatgory.clear();
    productInfoCatgory = productsData.where((product) => (product.category == category && product.id != id)).toList();
  }


  void filterSubCategoryProducts(String brandName){
    subCategoryProducts.clear();
    subCategoryProducts = productsData.where((product) => ((product.brandName == brandName) || product.type == brandName)).toList();
  }

  void filterProductInfo(int productId){
    productInfoData.clear();
    productInfoData = productsData.where((product) => product.id == productId).toList();
  }

  void filterFlashSaleProductInfo(int productId){
     productInfoData.clear();
     productInfoData = flashSaleProductsData.where((product) => product.id == productId).toList();
  }
}