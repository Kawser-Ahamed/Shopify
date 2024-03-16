class UserOrdersModel{

  List<dynamic>? userOrders;
  int orderId;
  String status;
  String reciever;
  double grandTotalPrice;
  String deliveryDate;
  String location;
  int state;

  UserOrdersModel(
    {
      required this.userOrders,
      required this.status,
      required this.reciever,
      required this.orderId,
      required this.location,
      required this.grandTotalPrice,
      required this.deliveryDate,
      required this.state,
    }
  );
  
}