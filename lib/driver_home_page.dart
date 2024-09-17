import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machine_task_2/db/route_db.dart';
import 'package:machine_task_2/models/route.dart';
import 'package:machine_task_2/route_details_screen.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  String? driverName;
  RouteModels? driverRoute;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getDriverDetails();
  }

  Future<void> _getDriverDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Fetch driver data from Firestore
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists && doc.data() != null) {
          setState(() {
            driverName = doc.data()!['name'];
          });

          // Fetch route from Hive based on the driver name
          List<RouteModels> routes = await RouteDb.singleton.getRoutes();
          driverRoute = routes.firstWhere(
            (route) => route.driver.name == driverName,
            // orElse: () => RouteModels(
            //     id: '', name: '', driver: null, stores: []), // fallback route
          );

          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print("Error fetching driver's route: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Home'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the button vertically
                children: [
                  Text(
                    'Welcome $driverName',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  RouteDetailsScreen(route: driverRoute!),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      backgroundColor: Colors.blue, // Text color
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Rounded corners
                      ),
                    ),
                    child: const Text('Show my Route'),
                  ),
                ],
              ),
            ),
    );
  }
}
