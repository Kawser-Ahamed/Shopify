import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/models/api/comments_model.dart';
import 'package:http/http.dart' as http;

class CommentsViewModel extends GetxController{

  List<CommentsModel> comments = <CommentsModel>[].obs;

  Future<List<CommentsModel>> getUsersComments () async{
    try{
      comments.clear();
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
      final data = jsonDecode(response.body.toString());
      if(response.statusCode==200){
        for(Map values in data){
          comments.add(CommentsModel.fromJson(values));
        }
        return comments;
      }
      else{
        return comments;
      }
    }
    catch(error){
      debugPrint(error.toString());
    }
    return comments;
  }
}