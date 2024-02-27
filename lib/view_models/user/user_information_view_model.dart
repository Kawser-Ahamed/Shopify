import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify/models/user/user_information_model.dart';

class ShopifyUserInformationViewModel extends GetxController{

  RxList<ShopifyUserInformationModel> userInformation = <ShopifyUserInformationModel>[].obs;
  RxBool  isLoading = true.obs;
  RxBool hasAccount = false.obs;

  @override
  void onInit() {
    getUserInformation();
    super.onInit();
  }

  Future<List<ShopifyUserInformationModel>> getUserInformation () async{
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var email = sharedPreferences.getString('email');
      if(email != null){
        QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(email.toString()).get();
        userInformation.value = querySnapshot.docs.map((DocumentSnapshot<Map<String,dynamic>> doc) => ShopifyUserInformationModel(
          email: doc['email'],
          name: doc['name'],
          mobileNumber: (doc['mobileNumber'] == null) ? "" : doc['mobileNumber'],
          profileImage: (doc['profileImage'] == null) ? "" : doc['profileImage'],
          points: doc['points'],
          latitude: doc.data()!.containsKey('latitude') ? doc['latitude'] : 0.0,
          longitude: doc.data()!.containsKey('longitude') ? doc['longitude'] : 0.0,
          location: doc.data()!.containsKey('location') ? doc['location'] : "",
        )).toList();
        hasAccount.value = true;
        update();
      }
      return userInformation;
    }
    catch(error){
      debugPrint(error.toString());
    }
    finally{
      isLoading.value = false;
    }
    return userInformation;
  }
}