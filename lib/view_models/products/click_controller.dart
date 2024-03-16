import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClickController extends GetxController{
  RxInt clickIndex = 0.obs;
  TextEditingController productName = TextEditingController();
  RxDouble lowPrice = 0.0.obs;
  RxDouble highPrice = 100000.0.obs;
  RxDouble ratings = 1.0.obs;
  RxString category = "".obs;
  RxString brand = "".obs;
  RxString brandImage = "".obs;
  RxString productId = "".obs;
  RxInt productIndex = 0.obs;
  RxBool scrollState = false.obs;
  RxInt sizeTapIndex = 0.obs;
  RxInt productQuantity = 1.obs;
  RxInt productRating = 0.obs;
  RxString size = "".obs;
  RxInt index = 0.obs;
}