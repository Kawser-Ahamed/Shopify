import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/resource/colors/app_color.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColor.backgroundColor,
        child: const Column(
          children: [
            Text('Profile'),
          ],
        ),
      ),
    );
  }
}