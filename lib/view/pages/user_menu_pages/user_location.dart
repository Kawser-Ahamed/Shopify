import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/colors/app_color.dart';

class UserLocation{

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
                Text("Add a new location for delivery",
                  style: TextStyle(
                    fontSize: (width/Screen.designWidth) * 35,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: height * 0.3,
                  width: width * 1,
                  color: Colors.red,
                  child: const GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(23.8118311, 90.3542672),
                      zoom: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

