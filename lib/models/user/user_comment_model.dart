class UserCommentModel{
    int productId;
    String userName;
    String comment;
    String dateTime;
    String commentId;

    UserCommentModel({required this.commentId,required this.productId, required this.userName,required this.comment,required this.dateTime});

    Map<String,dynamic> toJson(){
      return {
        'productId' : productId,
        'commentId' : commentId,
        'userName' : userName,
        'comment' : comment,
        'dateTime' : dateTime,
      };
    }
}