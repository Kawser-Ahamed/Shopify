class ShopifyUserSignupModel {

  String email;
  String password;
  String name;

  ShopifyUserSignupModel({required this.email,required this.password,required this.name});

  Map<String,dynamic> toJson() {
    return {
      'email' : email,
      'name' : name,
      'mobile Number' : null,
      'profileImage' : null,
    };
  }

}