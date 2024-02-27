import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify/models/authentication/shopify_user_signup_model.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/loading.dart';
import 'package:shopify/view_models/user/user_information_view_model.dart';

class ShopifyUserSignUpViewModel{
  
  bool isSingnUp = false;
  ShopifyUserInformationViewModel shopifyUserInformationViewModel = Get.find();

  Future<void> googleSignUp () async{
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
        shopifyUserInformationViewModel.getUserInformation();
        isSingnUp = true;
      }
    }
    catch(error){
        debugPrint(error.toString());
      }
  }

  Future<void> emailPasswordSignUp(ShopifyUserSignupModel shopifyUserSignupModel,BuildContext context) async{
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: shopifyUserSignupModel.email, 
        password: shopifyUserSignupModel.password,
      );
      await FirebaseFirestore.instance.collection(shopifyUserSignupModel.email).doc("Shopify-User-Information").set(
          shopifyUserSignupModel.toJson(),
        ).then((value){
        sharedPreferences.setString('email', shopifyUserSignupModel.email);
        shopifyUserInformationViewModel.getUserInformation();
        isSingnUp = true;
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      });
    }
    on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        Get.snackbar('Shopify', 'Weak Password.',
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
      else if(e.code == 'email-already-in-use'){
        Get.snackbar('Shopify', 'This Email Is Already Used By Someone.',
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
}