import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/models/products/categories_model.dart';

class CategoriesController extends GetxController{

  RxList<CategoriesModel> categoriesData = <CategoriesModel>[].obs;

  Future<List> getShopifyCategories () async{
    try{
      QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("Categories").get();
      categoriesData.value = querySnapshot.docs.map((DocumentSnapshot<Map<String,dynamic>> doc) => CategoriesModel(id: doc['id'], name: doc['name'], imageUrl: doc['imageUrl'],secondaryImage: doc['secondaryImage'])).toList();
      update();
      return categoriesData;
    }
    catch(error){
      debugPrint(error.toString());
    }
    return categoriesData;
  }
}