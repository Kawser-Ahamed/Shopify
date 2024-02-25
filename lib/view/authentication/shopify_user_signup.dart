import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/models/authentication/shopify_user_signup_model.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/app_logo_animation.dart';
import 'package:shopify/utils/reusable/custom_textfield.dart';
import 'package:shopify/view/pages/navigation_pages/mainpage.dart';
import 'package:shopify/view_models/authentication/shopify_user_signup_view_model.dart';

class ShopifyUserSignupPage extends StatefulWidget {
  const ShopifyUserSignupPage({super.key});

  @override
  State<ShopifyUserSignupPage> createState() => _ShopifyUserSignupPageState();
}

class _ShopifyUserSignupPageState extends State<ShopifyUserSignupPage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController shopifyUserName = TextEditingController();
  ShopifyUserSignUpViewModel shopifyUserSignUpViewModel = Get.put(ShopifyUserSignUpViewModel());

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(247,247,247,1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.05),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05),
              InkWell(
                onTap:(){
                  Get.back();
                },
                child: Container(
                  height: height * 0.06,
                  width: height * 0.06,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
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
                    padding: EdgeInsets.all((width/Screen.designWidth)*10),
                    child: const FittedBox(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              const AppLogoAnimation(),
              Text("Welcome To Shopify",
                  style: GoogleFonts.aBeeZee(
                    fontSize: (width/Screen.designWidth) * 40,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Buy product Anytime,Anywhere. Let's go.",
                  style: GoogleFonts.aBeeZee(
                    fontSize: (width/Screen.designWidth) * 30,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: height * 0.03),
                CustomTextField(hintText: "Enter your email address",controller: email,leadingIcon: Icons.mail,trailingIcon: false),
                SizedBox(height: height * 0.02),
                CustomTextField(hintText: "Password",controller: password,leadingIcon: Icons.password,trailingIcon: true),
                SizedBox(height: height * 0.02),
                CustomTextField(hintText: "Confirm Password",controller: confirmPassword,leadingIcon: Icons.password,trailingIcon: true),
                SizedBox(height: height * 0.02),
                CustomTextField(hintText: "User Name",controller: shopifyUserName,leadingIcon: Icons.person,trailingIcon: false),
                SizedBox(height: height * 0.03),
                InkWell(
                  onTap:(){
                    if(email.text.isEmpty || shopifyUserName.text.isEmpty || password.text.isEmpty || confirmPassword.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: AppColor.primaryColor,
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Shopify",
                              style: GoogleFonts.aBeeZee(
                                fontSize: (width/Screen.designWidth) * 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Please fill all the information",
                              style: TextStyle(
                                fontSize: (width/Screen.designWidth) * 30,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        )
                      ));
                    }
                    else if(password.text != confirmPassword.text){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: AppColor.primaryColor,
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Shopify",
                              style: GoogleFonts.aBeeZee(
                                fontSize: (width/Screen.designWidth) * 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Password & Confirm Password are not same.",
                              style: TextStyle(
                                fontSize: (width/Screen.designWidth) * 30,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        )
                      ));
                    }
                    else{
                      ShopifyUserSignupModel shopifyUserSignupModel = ShopifyUserSignupModel(email: email.text, password: password.text, name: shopifyUserName.text);
                      shopifyUserSignUpViewModel.emailPasswordSignUp(shopifyUserSignupModel, context).whenComplete((){
                        if(shopifyUserSignUpViewModel.isSingnUp){
                          Get.to(const MainPage());
                        }
                      });
                    }
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*100)),
                      gradient: const LinearGradient(colors: [Color.fromRGBO(148,191,88,1),Color.fromRGBO(184, 238, 109, 1)])
                    ),
                    child: Text("Signup",
                      style: GoogleFonts.aBeeZee(
                        fontSize: (width/Screen.designWidth) * 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: height * 0.002,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("OR",
                      textAlign: TextAlign.center,
                        style: GoogleFonts.aBeeZee(
                          fontSize: (width/Screen.designWidth) * 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: height * 0.002,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                InkWell(
                  onTap: (){
                    shopifyUserSignUpViewModel.googleSignUp().whenComplete((){
                      if(shopifyUserSignUpViewModel.isSingnUp){
                        Get.to(const MainPage());
                      }
                    });
                  },
                  child: Container(
                    height: height * 0.07,
                    width: width * 1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                      gradient: const LinearGradient(colors: [Colors.orange,Colors.red]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/google_logo.png',
                          height: height * 0.06,
                          width: height * 0.06,
                        ),
                        Text("Sign up with Google",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aBeeZee(
                            fontSize: (width/Screen.designWidth) * 35,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}