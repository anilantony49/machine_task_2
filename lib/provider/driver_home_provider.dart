import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_task_2/db/route_db.dart';
import 'package:machine_task_2/models/route.dart';

class DriverHomeProvider extends ChangeNotifier {
  String? driverName;
  RouteModels? driverRoute;
  bool isLoading = true;

  DriverHomeProvider() {
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
          driverName = doc.data()!['name'];
          

          // Fetch route from Hive based on the driver name
          List<RouteModels> routes = await RouteDb.singleton.getRoutes();
          driverRoute = routes.firstWhere(
            (route) => route.driver.name == driverName,
            
          );

          isLoading = false;
          notifyListeners();
        } else{
         isLoading = false;
        notifyListeners(); 
        }
      }
    } catch (e) {
      print("Error fetching driver's route: $e");
      isLoading = false;
      notifyListeners();
    }
  }
}
