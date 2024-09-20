import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:machine_task_2/provider/route_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RouteDetailScreenTwo extends StatelessWidget {
  final String storeName;
  final String storeAddress;

  const RouteDetailScreenTwo(
      {super.key, required this.storeName, required this.storeAddress});

  // bool isChecked = false; // Manage the checkbox state
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Shop Details'),
      ),
      body: Consumer<RouteDetailProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              ListTile(
                leading: Checkbox(
                  value: provider.isChecked(storeName),
                  onChanged: (value) {
                    provider.toggleCheckbox(storeName, value);
                  },
                ),
                title: Text(
                  storeName,
                  style: const TextStyle(fontSize: 16),
                ),
                subtitle: Text(storeAddress),
                trailing: TextButton(
                  onPressed: () {
                    _openMap(storeAddress);
                    print('View on Map for $storeName');
                  },
                  child: const Text('View on Map'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                provider.visitedTime(storeName).isEmpty
                    ? 'Visited time will appear here'
                    : 'Visited at: ${provider.visitedTime(storeName)}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          );
        },
      ),
    );
  }
}
