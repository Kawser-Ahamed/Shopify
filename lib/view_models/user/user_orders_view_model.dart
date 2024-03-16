import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify/models/user/user_orders_model.dart';

class UserOrdersViewModel extends GetxController{

  RxList<UserOrdersModel> userOrdersData = <UserOrdersModel>[].obs;

  Future<RxList<UserOrdersModel>> getUserOrders() async{

    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('${sharedPreferences.getString('email').toString()}-Orders').get();
      userOrdersData.value = querySnapshot.docs.map((DocumentSnapshot<Map<String,dynamic>> doc) => UserOrdersModel(
        userOrders: doc['products'],
        orderId : doc['orderId'],
        reciever: doc['reciever'],
        deliveryDate: doc['deliveryDate'],
        grandTotalPrice: doc['grandTotalPrice'],
        status: doc['status'],
        state : doc['state'],
        location: doc['location'],
      )).toList();
    }
    catch(error){
      debugPrint(error.toString());
    }
    return userOrdersData;
  }
}