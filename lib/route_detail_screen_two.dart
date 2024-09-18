import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class RouteDetailScreenTwo extends StatefulWidget {
  final String storeName;
  final String storeAddress;

  const RouteDetailScreenTwo(
      {super.key, required this.storeName, required this.storeAddress});

  @override
  State<RouteDetailScreenTwo> createState() => _RouteDetailScreenTwoState();
}

class _RouteDetailScreenTwoState extends State<RouteDetailScreenTwo> {
  bool isChecked = false; // Manage the checkbox state
  String visitedTime = ""; // To store and display the time
  // Function to launch Google Maps with the store's coordinates
  Future<void> _openMap(String address) async {
    try {
      // Get the coordinates (latitude and longitude) from the store's address
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final double latitude = locations[0].latitude;
        final double longitude = locations[0].longitude;

        // Construct the Google Maps URL to provide directions
        String googleMapsUrl =
            "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}&query_place_id=$latitude,$longitude";

        // Launch the URL
        // ignore: deprecated_member_use
        if (await canLaunch(googleMapsUrl)) {
          // ignore: deprecated_member_use
          await launch(googleMapsUrl);
        } else {
          throw 'Could not open the map.';
        }
      }
    } catch (e) {
      print("Error occurred while fetching location: $e");
    }
  }

  // Function to handle the checkbox and set the current time
  void _handleCheckboxChange(bool? value) {
    setState(() {
      isChecked = value ?? false;

      if (isChecked) {
        // Get the current time when the checkbox is checked
        visitedTime = DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now());
      } else {
        visitedTime = ""; // Clear the time if unchecked
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Shop Details'),
      ),
      body: Column(
        children: [
          ListTile(
            leading:
                Checkbox(value: isChecked, onChanged: _handleCheckboxChange),
            title: Text(
              widget.storeName,
              style: const TextStyle(fontSize: 16),
            ),
            subtitle: Text(widget.storeAddress),
            trailing: TextButton(
              onPressed: () {
                _openMap(widget.storeAddress);
                print('View on Map for ${widget.storeName}');
              },
              child: const Text('View on Map'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            visitedTime.isEmpty
                ? 'Visited time will appear here'
                : 'Visited at: $visitedTime',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
