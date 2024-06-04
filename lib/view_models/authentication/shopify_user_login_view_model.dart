import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopify/models/authentication/shopify_user_login_model.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify/view_models/user/user_information_view_model.dart';

class ShopifyUserLoginViewModel extends GetxController{
    bool isLoggedIn = false;
    ShopifyUserInformationViewModel shopifyUserInformationViewModel = Get.find();
   
  Future<void> googleLogin () async{
    try{
      final auth = FirebaseAuth.instance;
      final googleSignIn = GoogleSignIn();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      
      if(googleSignInAccount != null){
      
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential = await auth.signInWithCredential(authCredential);

        if(userCredential.additionalUserInfo?.isNewUser ?? false){
          FirebaseFirestore.instance.collection(userCredential.user!.email.toString()).doc("Shopify-User-Information").set({
            'email' : userCredential.user!.email.toString(),
            'name' : userCredential.user!.displayName.toString(),
            'profileImage' : userCredential.user!.photoURL.toString(),
            'mobileNumber' : userCredential.user!.phoneNumber.toString(),
            'points' : 0,
          });
        }
        else{
          debugPrint('old Id Logged In');
        }
        sharedPreferences.setString('email', userCredential.user!.email.toString());
        shopifyUserInformationViewModel.getUserInformation;
        isLoggedIn = true;
        //Get.to(const MainPage(),transition: Transition.zoom);
      }
    }
    catch(error){
      debugPrint(error.toString());
    }
  }

  Future<void> emailPasswordSignIn(ShopifyUserLoginModel shopifyUserLoginModel,BuildContext context) async{
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) {
        return Center(
          child: Loading(color: AppColor.primaryColor, size: 0.05),
        );
      },
    );

    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: shopifyUserLoginModel.email, 
        password: shopifyUserLoginModel.password,
      ).then((value){
        isLoggedIn = true;
        sharedPreferences.setString('email', shopifyUserLoginModel.email);
        shopifyUserInformationViewModel.getUserInformation();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      });
    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        Get.snackbar('Shopify', 'Email Address Is Invalid.',
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
      else if(e.code == 'wrong-password'){
        Get.snackbar('Shopify', 'Password Is Incorrect.',
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
      else{
        Get.snackbar('Shopify', 'Your Email Or Password Is Incorrect.',
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    }
    catch(error){
      debugPrint(error.toString());
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  Future<void> resetPassword(String email) async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email).whenComplete((){
        Get.snackbar('Shopify', 'We have send you a reset email.Please check it & change password.',
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      });
    }
    catch(error){
      Get.snackbar('Shopify', 'Please try again.',
        backgroundColor: AppColor.primaryColor,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }
}