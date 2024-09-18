// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class MapScreen extends StatefulWidget {
//   final double latitude;
//   final double longitude;

//   MapScreen({required this.latitude, required this.longitude});

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//   LocationData? currentLocation;

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   Future<void> _getUserLocation() async {
//     Location location = Location();
//     currentLocation = await location.getLocation();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Assigned Store Location'),
//       ),
//       body: currentLocation == null
//           ? Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(widget.latitude, widget.longitude),
//                 zoom: 14.0,
//               ),
//               markers: {
//                 Marker(
//                   markerId: MarkerId('storeLocation'),
//                   position: LatLng(widget.latitude, widget.longitude),
//                   infoWindow: InfoWindow(
//                     title: 'Assigned Store',
//                     snippet: 'Directions to store',
//                   ),
//                 ),
//               },
//             ),
//     );
//   }
// }
