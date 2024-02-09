import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  final double height;
  final double width;
  final double size;
  final String text;
  final Color color;
  final bool bold;
  const CustomText({super.key,required this.text, required this.height, required this.width, required this.color, required this.bold, required this.size,});

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * widget.height,
      width: screenWidth * widget.width,
      color: Colors.transparent,
      alignment: Alignment.centerLeft,
      child: FittedBox(
        child: Text(widget.text,
          style: TextStyle(
            color: widget.color,
            fontSize: screenWidth * widget.size,
            fontWeight: (widget.bold) ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}