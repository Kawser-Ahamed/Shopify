// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';


// class LocationConverter extends StatefulWidget {
//   @override
//   _LocationConverterState createState() => _LocationConverterState();
// }

// class _LocationConverterState extends State<LocationConverter> {
//   double latitude = 23.8118311; // Example latitude
//   double longitude = 90.3542672; // Example longitude
//   String location = '';

//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> getLocationFromCoordinates() async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(23.8086794, 90.3545352);
//       setState(() {
//         location = placemarks.reversed.last.subLocality.toString();
//       });
//     } catch (e) {
//       print('Error getting location: $e');
//       setState(() {
//         location = 'Error';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location Converter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Latitude: $latitude\nLongitude: $longitude',
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Location: $location',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             TextButton(
//               onPressed: (){
//                 getLocationFromCoordinates();
//               }, 
//               child: const Text('Press')
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
