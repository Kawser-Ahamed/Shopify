import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopify/firebase_options.dart';
import 'package:shopify/view/authentication/shopify_user_signup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const Shopify());
}

class Shopify extends StatelessWidget {
  const Shopify({super.key});
   
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: const ShopifyUserSignup(),
      debugShowCheckedModeBanner: false,
    );
  }
}

