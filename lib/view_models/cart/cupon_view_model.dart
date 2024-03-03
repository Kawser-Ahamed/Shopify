import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/models/cart/cupon_model.dart';
import 'package:shopify/view_models/cart/cart_view_model.dart';

class CuponViewModel extends GetxController{

  RxList<CuponModel> cuponData = <CuponModel>[].obs;
  CartViewModel cartViewModel = Get.find();

  Future<RxList<CuponModel>> getCuponData() async{
    try{
      final snapshot = await FirebaseDatabase.instance.ref('Cupon').once();
      final data = snapshot.snapshot.value as Map<dynamic,dynamic>;
      debugPrint(data.toString());
      cuponData.value = data.entries.map((entry){
        return CuponModel(
          id: entry.value['id'], 
          cuponName: entry.value['cuponName'],
          discountPercentage: entry.value['discountPercentage'],
        );
      }).toList();
      return cuponData;
    }
    catch(error){
      debugPrint('Cupon Error: ${error.toString()}');
    }
    return cuponData;
  }

  void cuponDiscount(String cuponNameFromUser){
    for (var cupons in cuponData) {
      if(cupons.cuponName==cuponNameFromUser){
        cartViewModel.totalPrice.value-=100;
      }
    }
  }
}