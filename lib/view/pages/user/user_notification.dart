import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/cart_icon_design.dart';
import 'package:shopify/utils/reusable/loading.dart';
import 'package:shopify/view/pages/navigation_pages/mainpage.dart';
import 'package:shopify/view_models/user/user_notification_view_model.dart';

class UserNotification extends StatefulWidget {
  const UserNotification({super.key});

  @override
  State<UserNotification> createState() => _UserNotificationState();
}

class _UserNotificationState extends State<UserNotification> {

  UserNotificationViewModel userNotificationViewModel = Get.put(UserNotificationViewModel());

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height * 0.1,
            width: width * 1,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: (){
                      Get.back();
                    },
                     icon: Icon(Icons.arrow_back_ios_new,size:(width/Screen.designWidth)*60,color: Colors.black,),
                  ),
                  Text("Notification",
                    style: TextStyle(
                    fontSize: (width/Screen.designWidth) * 40,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  const CartIconsDesign(iconsHeight: 0.07, iconWidth: 0.07, color: Colors.black),
                ]
              ),
            ),
          ),
          Expanded(
            child: Obx(() => FutureBuilder(
              future: userNotificationViewModel.getUserNotification(), 
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  if(userNotificationViewModel.userNotificationData.isEmpty){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You have no notification",
                          style: GoogleFonts.aBeeZee(
                            fontSize: (width/Screen.designWidth) * 30,
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            Get.to(const MainPage(),transition: Transition.fade);
                          }, 
                          child: Text("Go to Homepage",
                            style: GoogleFonts.aBeeZee(
                              fontSize: (width/Screen.designWidth) * 30,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  else{
                    return ListView.builder(
                      itemCount: userNotificationViewModel.userNotificationData.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0,
                          color: Colors.white,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                )
                              ]
                            ),
                            child: ListTile(
                              leading: Image.network(snapshot.data![index].imageUrl),
                              title: Text(snapshot.data![index].title,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: (width/Screen.designWidth) * 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(snapshot.data![index].description,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: (width/Screen.designWidth) * 25,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
                else{
                  return Center(child: Loading(color: AppColor.primaryColor, size: 0.08));
                }
              },
            )),
          ),
        ],
      ),
    );
  }
}