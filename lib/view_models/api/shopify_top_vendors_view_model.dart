import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/models/api/shopify_top_vendors_model.dart';
import 'package:http/http.dart' as http;

class ShopifyTopVendorsViewModel extends GetxController{

  RxList<Users> shopifyTopVendorsList = <Users>[].obs;
  List<Users> vendorsList = [];

  Future<RxList<Users>> getShopifyTopVendorsList() async{
    try{
      var response = await http.get(Uri.parse('https://dummyjson.com/users'));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString())['users'];
        for (var values in data){
          vendorsList.add(Users.fromJson(values));
        }
        shopifyTopVendorsList.assignAll(vendorsList);
        return shopifyTopVendorsList;
      }
    }
    catch(error){
      debugPrint('error: ${error.toString()}');
    }
    return shopifyTopVendorsList;
  }
}