import 'package:flutter/material.dart';
import 'package:shopify/data/screen.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData leadingIcon;
  final bool trailingIcon;
  final String hintText;
  const CustomTextField({super.key, required this.controller, required this.leadingIcon, required this.trailingIcon, required this.hintText});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool  showPassword = true;
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return Container(
      height: height * 0.07,
      width : width * 1,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*100)),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 2,
          )
        ]
      ),
      child: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: widget.controller,
          obscureText: (widget.trailingIcon && showPassword) ? showPassword : false,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.leadingIcon,color: Colors.black),
            suffixIcon: (widget.trailingIcon) ? InkWell(
              onTap: (){
                showPassword = ! showPassword;
                setState(() {
                  
                });
              },
              child: (showPassword) ? const Icon(Icons.visibility,color: Colors.black) : const Icon(Icons.visibility_off,color: Colors.black)) : null,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: (width/Screen.designWidth) * 35,
            ),
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ),
    );
  }
}