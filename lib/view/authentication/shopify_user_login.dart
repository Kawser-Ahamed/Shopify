import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/models/authentication/shopify_user_login_model.dart';
import 'package:shopify/resource/assets/app_images.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/app_logo_animation.dart';
import 'package:shopify/utils/reusable/custom_textfield.dart';
import 'package:shopify/view/authentication/shopify_user_signup.dart';
import 'package:shopify/view/pages/navigation_pages/mainpage.dart';
import 'package:shopify/view_models/authentication/shopify_user_login_view_model.dart';

class ShopifyUserLoginPage extends StatefulWidget {
  const ShopifyUserLoginPage({super.key});

  @override
  State<ShopifyUserLoginPage> createState() => _ShopifyUserLoginPageState();
}

class _ShopifyUserLoginPageState extends State<ShopifyUserLoginPage> with TickerProviderStateMixin{

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  ShopifyUserLoginViewModel shopifyUserLoginViewModel = Get.put(ShopifyUserLoginViewModel());

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: height * 0.27,
                  width: height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.loginScreenImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const AppLogoAnimation(),
              Text("Welcome To Shopify",
                style: GoogleFonts.aBeeZee(
                  fontSize: (width/Screen.designWidth) * 40,
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Let's begin your journy with us.",
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
              TextButton(
                onPressed: (){
          
                },
                child: Text("Forgot your password?",
                  style: GoogleFonts.aBeeZee(
                    fontSize: (width/Screen.designWidth) * 35,
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: (){
                  Get.to(const ShopifyUserSignupPage(),transition: Transition.rightToLeftWithFade);
                },
                child: Text("Don't Have a account? Signup",
                  style: GoogleFonts.aBeeZee(
                    fontSize: (width/Screen.designWidth) * 35,
                    color: const Color.fromRGBO(148,191,88,1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap:(){
                  if(email.text.isEmpty || password.text.isEmpty){
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
                          Text("Please fill email and password",
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
                    ShopifyUserLoginModel shopifyUserLoginModel = ShopifyUserLoginModel(email: email.text, password: password.text);
                    shopifyUserLoginViewModel.emailPasswordSignIn(shopifyUserLoginModel,context).whenComplete((){
                      if(shopifyUserLoginViewModel.isLoggedIn){
                        Get.to(const MainPage(),transition: Transition.cupertinoDialog);
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
                    gradient: const LinearGradient(colors: [Color.fromRGBO(0,97,174,1),Color.fromRGBO(0,61,117,1)])
                  ),
                  child: Text("Login",
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
                  shopifyUserLoginViewModel.googleLogin().whenComplete((){
                    if(shopifyUserLoginViewModel.isLoggedIn){
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
                      Text("Sign in with Google",
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
            ]
          ),
        ),
      ),
    );
  }
}