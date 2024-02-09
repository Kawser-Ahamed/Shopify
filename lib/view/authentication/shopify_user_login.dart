import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/assets/app_images.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/app_logo_animation.dart';
import 'package:shopify/utils/reusable/custom_textfield.dart';

class ShopifyUserLoginPage extends StatefulWidget {
  const ShopifyUserLoginPage({super.key});

  @override
  State<ShopifyUserLoginPage> createState() => _ShopifyUserLoginPageState();
}

class _ShopifyUserLoginPageState extends State<ShopifyUserLoginPage> with TickerProviderStateMixin{

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
                  height: height * 0.3,
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
              Container(
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
              Container(
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
              SizedBox(height: height * 0.02),
            ]
          ),
        ),
      ),
    );
  }
}