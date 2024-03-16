import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify/data/navbar_controller.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/data/user_profile_data.dart';
import 'package:shopify/resource/assets/app_images.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/app_bar.dart';
import 'package:shopify/utils/reusable/names.dart';
import 'package:shopify/view/authentication/shopify_user_login.dart';
import 'package:shopify/view/pages/products/search.dart';
import 'package:shopify/view/pages/user/user_location.dart';
import 'package:shopify/view/pages/user/user_notification.dart';
import 'package:shopify/view/pages/user/user_order.dart';
import 'package:shopify/view_models/user/user_information_view_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  ShopifyUserInformationViewModel shopifyUserInformationViewModel = Get.find();
  NavBarController navBarController = Get.find();
  UserProfileData profileData = UserProfileData();
  UserLocation userLocation = UserLocation();
  
  @override
  void initState(){
    shopifyUserInformationViewModel.getUserInformation().whenComplete((){
      setState((){});
      // debugPrint(shopifyUserInformationViewModel.userInformation.length.toString());
    });
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child:(shopifyUserInformationViewModel.userInformation.isEmpty) ? SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ShopifyAppBar(),
              Padding(
                padding: EdgeInsets.only(left: width * 0.03),
                child: Text("Welcome To ${Names.appName}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aBeeZee(
                    fontSize: (width/Screen.designWidth) * 40,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
              Container(
                height: height * 0.2,
                width: width * 1,
                margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage(AppImages.freeDeliveryOffer),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                height: height * 0.3,
                width: width * 1,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage(AppImages.catImageForProfile),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text("OOPS! You don't have a account or you did't log into your account",
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  fontSize: (width/Screen.designWidth) * 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.02),
              InkWell(
                onTap: (){
                  Get.to(const ShopifyUserLoginPage(),transition: Transition.leftToRightWithFade);
                },
                child: Container(
                  height: height * 0.07,
                  width: width * 1,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth) * 20)),
                  ),
                  child: Text("Login / SignUp",
                    style: GoogleFonts.aBeeZee(
                      fontSize:(width/Screen.designWidth) * 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ) :  Stack(
          children: [
            Container(
              height : height * 0.3,
              width: width * 1,
              color: AppColor.primaryColor,
              child: Column(
                children: [
                  SizedBox(height: height * 0.05),
                  (shopifyUserInformationViewModel.userInformation[0].profileImage.isEmpty) 
                  ? Container(
                    height: height * 0.1,
                    width: height * 0.1,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                    ),
                    child: Text(shopifyUserInformationViewModel.userInformation[0].name[0],
                      style: TextStyle(
                        fontSize: (width/Screen.designWidth) * 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  :CircleAvatar(
                    backgroundImage: NetworkImage(shopifyUserInformationViewModel.userInformation[0].profileImage),
                    radius: height * 0.05,
                  ),
                  SizedBox(height: height * 0.01),
                  Text(shopifyUserInformationViewModel.userInformation[0].name,
                    style: GoogleFonts.aBeeZee(
                      fontSize: (width/Screen.designWidth) * 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(shopifyUserInformationViewModel.userInformation[0].email,
                    style: GoogleFonts.aBeeZee(
                      fontSize: (width/Screen.designWidth) * 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            Positioned(
              top: height * 0.25,
              bottom: height * 0.55,
              left: width * 0.03,
              right: width * 0.03,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      spreadRadius: 2,
                    )
                  ]
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap:(){
                          Get.to(const Search(),transition: Transition.rightToLeftWithFade);
                        },
                        child: Icon(Icons.search, 
                          size: (width/Screen.designWidth) * 50,
                        ),
                      ),
                      InkWell(
                        onTap:(){
                          Get.to(const UserNotification(),transition: Transition.rightToLeftWithFade);
                        },
                        child: Icon(Icons.notifications_none, 
                          size: (width/Screen.designWidth) * 50,
                        ),
                      ),
                      InkWell(
                        onTap:() async{
                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          googleSignIn.signOut();
                          auth.signOut();
                          navBarController.pageIndex.value = 0;
                          sharedPreferences.remove('email');
                          Get.to(const ShopifyUserLoginPage());
                        },
                        child: Icon(Icons.logout, 
                          size: (width/Screen.designWidth) * 50,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),
            Obx(() => Positioned(
              top: height * 0.35,
              bottom: height * 0.32,
               left: width * 0,
               right: width * 0.01,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.02),
                decoration: BoxDecoration(
                  color: (shopifyUserInformationViewModel.userInformation[0].points <100) ? Colors.greenAccent 
                       : (shopifyUserInformationViewModel.userInformation[0].points >=100 && shopifyUserInformationViewModel.userInformation[0].points <200) ? Colors.blueGrey 
                       : (shopifyUserInformationViewModel.userInformation[0].points >=200 && shopifyUserInformationViewModel.userInformation[0].points <300) ?  Colors.deepOrange
                       : (shopifyUserInformationViewModel.userInformation[0].points >=300 && shopifyUserInformationViewModel.userInformation[0].points <400) ? Colors.deepPurple
                       : Colors.pink,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      spreadRadius: 2,
                    ),
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Text(shopifyUserInformationViewModel.userInformation[0].name,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: (width / Screen.designWidth) * 30,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white
                            ),
                          ),),
                          Row(
                            children: [
                              Icon(Icons.stars, 
                                size: (width/Screen.designWidth) * 50,
                                color: Colors.yellow,
                              ),
                              SizedBox(width: width * 0.03,),
                              Obx(() => Text('${shopifyUserInformationViewModel.userInformation[0].points.toString()} Points',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: (width / Screen.designWidth) * 30,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white
                                ),
                              ),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    (shopifyUserInformationViewModel.userInformation[0].points<100) ? Text('Titanium',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: (width / Screen.designWidth) * 35,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white
                      ),
                    ) :  (shopifyUserInformationViewModel.userInformation[0].points>=100 && shopifyUserInformationViewModel.userInformation[0].points<200) ? Text('Silver',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: (width / Screen.designWidth) * 35,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white
                      ),
                    ) : (shopifyUserInformationViewModel.userInformation[0].points>=200 && shopifyUserInformationViewModel.userInformation[0].points<300) ? Text('Gold',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: (width / Screen.designWidth) * 35,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white
                      ),
                    ) : (shopifyUserInformationViewModel.userInformation[0].points>=300 && shopifyUserInformationViewModel.userInformation[0].points<400) ? Text('Platinum',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: (width / Screen.designWidth) * 35,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white
                      ),
                    )  : Text('Diamond',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: (width / Screen.designWidth) * 35,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: height * 0.02,),
                    Container(
                      height: height * 0.02,
                      width: width * 1,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*100)),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: (width * 0.9) * (((shopifyUserInformationViewModel.userInformation[0].points % 100) / 100).clamp(0.0, 1.0)),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*100)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
            Positioned(
              top: height * 0.58,
              bottom: height * 0.08,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.03,top: height * 0.01,bottom: height * 0.01),
                      child: Text('My Menu',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: (width / Screen.designWidth) * 35,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black
                        ),
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: (height * 0.01),
                          crossAxisSpacing: (width * 0.05),
                          childAspectRatio: width / (height / 3),
                        ), 
                        itemCount: profileData.userProfileData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap:(){
                              if(index==0){
                                Get.to(const UserOrder(),transition: Transition.fade);
                              }
                              else if(index==1){
                                debugPrint('location: ${shopifyUserInformationViewModel.userInformation[0].location}');
                                userLocation.getUserLocation(context);
                              }
                            },
                            child: Container(
                              height: height * 0.05,
                              width: height * 0.1,
                              margin: EdgeInsets.symmetric(horizontal: (width * 0.02)),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*10)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: height* 0.05,
                                    width: height * 0.05,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(profileData.userProfileData.values.elementAt(index)),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text(profileData.userProfileData.keys.elementAt(index),
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: (width / Screen.designWidth) * 25,
                                      fontWeight: FontWeight.normal,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}