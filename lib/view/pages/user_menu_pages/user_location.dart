import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/view_models/user/user_information_view_model.dart';
import 'package:shopify/view_models/user/user_location_view_model.dart';

class UserLocation{ 

  UserLocationViewModel userLocationViewModel = Get.put(UserLocationViewModel());
   ShopifyUserInformationViewModel shopifyUserInformationViewModel = Get.find();
   
  Future getUserLocation(BuildContext context) async{
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return showModalBottomSheet(
      context: context, 
      builder: (context) {
        return Container(
          height: height * 0.4,
          width: width * 1,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.add,
                      size: (width/Screen.designWidth) * 40,
                    ),
                    SizedBox(width: width * 0.03,),
                    Text("Add a new location for delivery",
                      style: TextStyle(
                        fontSize: (width/Screen.designWidth) * 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: height * 0.3,
                  width: width * 1,
                  color: Colors.grey.shade300,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: (shopifyUserInformationViewModel.userInformation[0].location!.isEmpty) ? const LatLng(23.8118311, 90.3542672) : LatLng(shopifyUserInformationViewModel.userInformation[0].latitude!.toDouble(), shopifyUserInformationViewModel.userInformation[0].longitude!.toDouble()),
                      zoom: 18,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('user-location'),
                        position: (shopifyUserInformationViewModel.userInformation[0].location!.isEmpty) ? const LatLng(23.8118311, 90.3542672) : LatLng(shopifyUserInformationViewModel.userInformation[0].latitude!.toDouble(), shopifyUserInformationViewModel.userInformation[0].longitude!.toDouble()),
                      )
                    },
                  ),
                ),
               TextButton(
                  onPressed: (){
                    userLocationViewModel.sendShopifyUserLocation();
                  }, 
                  child: Text("Add My Current Location",
                    style: TextStyle(
                      fontSize: (width/Screen.designWidth) * 35,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

