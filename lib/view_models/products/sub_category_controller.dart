
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/models/products/sub_category_model.dart';

class SubCategoryController extends GetxController{

  RxList<SubCategory> subCategoryData = <SubCategory>[].obs;

  Future<List<SubCategory>> getSubCategoryData(String reference) async{

    try{
      QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(reference).get();
      subCategoryData.value = querySnapshot.docs.map((DocumentSnapshot<Map<String,dynamic>> doc) => SubCategory(id: doc['id'], name: doc['name'])).toList();
      update();
      return subCategoryData;
    }
    catch(error){
      debugPrint(error.toString());
    }
    return subCategoryData;
  }
}