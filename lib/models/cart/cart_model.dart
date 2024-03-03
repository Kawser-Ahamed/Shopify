class CartModel{

  int productId;
  String productName;
  String productImageUrl;
  int price;
  String size;
  int quantity;
  int totalPrice;
  int originalQuantity;
  int deliveryCharge;

  CartModel({
    required this.productId,
    required this.productName,
    required this.productImageUrl,
    required this.price,
    required this.size,
    required this.quantity,
    required this.totalPrice,
    required this.originalQuantity,
    required this.deliveryCharge,
  });


}