import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/models/user/user_comment_model.dart';

class UserCommentViewModel extends GetxController{
  
  RxList<UserCommentModel> userCommentsData = <UserCommentModel>[].obs;

  Future<void> userComment(UserCommentModel userCommentModel) async{
    FirebaseDatabase.instance.ref(userCommentModel.productId.toString()).child(userCommentModel.commentId).set(userCommentModel.toJson());
  }

  Future<RxList<UserCommentModel>> getUserComments(int productId) async{
    try{
      userCommentsData.clear();
      final snapshot = await FirebaseDatabase.instance.ref(productId.toString()).once();
      final data = snapshot.snapshot.value as Map<dynamic,dynamic>;
      userCommentsData.value = data.entries.map((comments){
        return UserCommentModel(
          commentId: comments.value['commentId'], 
          productId: comments.value['productId'], 
          userName: comments.value['userName'], 
          comment: comments.value['comment'], 
          dateTime: comments.value['dateTime'],
        );
      }).toList();
    }
    catch(error){
      debugPrint(error.toString());
    }
    return userCommentsData;
  }
}