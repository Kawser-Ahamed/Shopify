// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopify/view_models/user/user_orders_view_model.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {

//   UserOrdersViewModel userOrdersViewModel = Get.put(UserOrdersViewModel());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: FutureBuilder(
//         future: userOrdersViewModel.getUserOrders(), 
//         builder: (context, snapshot) {
//           return ListView.builder(
//             itemCount: userOrdersViewModel.userOrdersData.length,
//             itemBuilder: (context, index) {
//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: userOrdersViewModel.userOrdersData[index].userOrders!.length,
//                 itemBuilder: (context, innerIndex) {
//                   return Column(
//                     children: [
//                       Text(userOrdersViewModel.userOrdersData[index].userOrders!.elementAt(innerIndex)['name']),
//                       Text(userOrdersViewModel.userOrdersData[index].reciever),
//                     ],
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }