import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/models/carasoul/main_carasoul_model.dart';

class MainCarasoulController extends GetxController{

    RxList<MainCarasoul> mainCarasoulData = <MainCarasoul>[].obs;

    Future<List> getMainCarasoulData() async{
      try{
        QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("main-carousel").get();
        mainCarasoulData.value = querySnapshot.docs.map((DocumentSnapshot<Map<String,dynamic>> doc) => MainCarasoul(id: doc['id'], imageUrl: doc['imageUrl'])).toList();
        return mainCarasoulData;
      }
      catch(error){
        debugPrint(error.toString());
      }
      return mainCarasoulData;
    }
}