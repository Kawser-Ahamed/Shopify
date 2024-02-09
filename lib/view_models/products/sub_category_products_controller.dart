import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/models/products/sub_category_products_model.dart';

class SubCategoryProductsController extends GetxController{

  RxString collectionName = "".obs;
  RxInt index = 0.obs;
  RxList<SubCategoryProducts> subCategoryProductsData = <SubCategoryProducts>[].obs;
  
  Future<List<SubCategoryProducts>> getSubCategoryProducts(String name) async{
    try{
      QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(name).get();
      subCategoryProductsData.value = querySnapshot.docs.map((DocumentSnapshot<Map<String,dynamic>> doc) => SubCategoryProducts(id: doc['id'], name: doc['name'], imageUrl: doc['imageUrl'])).toList();
      update();
      return subCategoryProductsData;
    }
    catch(error){
      debugPrint(error.toString());
    }
    return subCategoryProductsData;
  }
}