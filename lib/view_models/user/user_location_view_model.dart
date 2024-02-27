import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocationViewModel{

  Future<void> sendShopifyUserLocation() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      var status = await Permission.location.request();
      if(status.isGranted){
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        FirebaseFirestore.instance.collection(sharedPreferences.getString('email').toString()).doc("Shopify-User-Information").update({
          'latitude' : position.latitude,
          'longitude' : position.longitude,
          'location' : '${placemarks.reversed.last.subLocality} ${placemarks.reversed.last.locality} ${placemarks.reversed.last.country}',
        }).then((value) => debugPrint('Data has been send'));
      }
      else if(status.isDenied){
        Get.snackbar('Permission Denied', 'Location permission is denied. Please grant the permission from the device settings to get the current location',
          //backgroundColor: AppColor.primaryColor,
          colorText: Colors.black,
        );
      }
      else if(status.isPermanentlyDenied){
         Get.snackbar('Permission Permanently Denied', 'Location permission is denied. Please grant the permission from the device settings to get the current location',
          //backgroundColor: AppColor.primaryColor,
          colorText: Colors.black,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("Error to fetch location");
    }
  }
}
