class ProductsModel{

  int id;
  String productName;
  int price;
  int oldPrice;
  String primaryImageUrl;
  String category;
  double ratings;
  String productDescription;
  int deliveryCharge;
  String brandName;
  String type;
  int quantity;
  List<String>? productSize = [];

  ProductsModel({
    required this.id,
    required this.productName,
    required this.price,
    required this.primaryImageUrl,
    required this.ratings, 
    required this.category,
    required this.brandName,
    required this.productDescription,
    required this.quantity,
    this.oldPrice=0, 
    this.deliveryCharge=0,
    required this.type,
    this.productSize,
  });
}