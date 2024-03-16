import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/models/user/user_notification_model.dart';
import 'package:shopify/view_models/user/user_information_view_model.dart';

class UserNotificationViewModel extends GetxController{

  RxList<UserNotificationModel> userNotificationData = <UserNotificationModel>[].obs;
  ShopifyUserInformationViewModel shopifyUserInformationViewModel = Get.find();

  Future<RxList<UserNotificationModel>> getUserNotification() async{
    try{
      QuerySnapshot<Map<dynamic,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('${shopifyUserInformationViewModel.userInformation.first.email.toString()}-Notification').get();
      userNotificationData.value = querySnapshot.docs.map((DocumentSnapshot<Map<dynamic,dynamic>> doc) => UserNotificationModel(
        title: doc['title'],
        description: doc['description'],
        imageUrl: doc['imageUrl'],
      )).toList();
      return userNotificationData;
    }
    catch(error){
      debugPrint(error.toString());
    }
    return userNotificationData;
  }
}