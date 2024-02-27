class ShopifyUserInformationModel{

  String email;
  String name;
  String profileImage;
  String mobileNumber;
  int points;
  double? latitude;
  double? longitude;
  String? location;

  ShopifyUserInformationModel({required this.email,required this.name,required this.mobileNumber,required this.profileImage,required this.points,this.latitude,this.longitude,this.location});

}