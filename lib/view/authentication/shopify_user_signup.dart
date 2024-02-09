import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/app_logo_animation.dart';
import 'package:shopify/utils/reusable/custom_textfield.dart';

class ShopifyUserSignup extends StatefulWidget {
  const ShopifyUserSignup({super.key});

  @override
  State<ShopifyUserSignup> createState() => _ShopifyUserSignupState();
}

class _ShopifyUserSignupState extends State<ShopifyUserSignup> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController shopifyUserName = TextEditingController();

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
              SizedBox(height: height * 0.1),
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
                CustomTextField(hintText: "User Name",controller: password,leadingIcon: Icons.person,trailingIcon: false),
                SizedBox(height: height * 0.03),
                Container(
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
                SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}