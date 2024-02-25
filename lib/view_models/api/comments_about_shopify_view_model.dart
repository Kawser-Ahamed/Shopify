import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopify/models/api/comments_about_shopify_model.dart';

class CommentsAboutShopifyViewModel extends GetxController{

  RxList<Comments>  commentsAboutShopifyData = <Comments>[].obs;
  List<Comments> comment = <Comments>[];
  
  Future<RxList<Comments>> getUserCommentsAboutShopify() async{
    try{
  
      var response = await http.get(Uri.parse('https://dummyjson.com/comments'));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString())['comments'];
        for(var values in data){
          comment.add(Comments.fromJson(values));
        }
        commentsAboutShopifyData.assignAll(comment);
        return commentsAboutShopifyData;
      }
    }
    catch(error){
      debugPrint(error.toString());
    }
    return commentsAboutShopifyData;
  }
}