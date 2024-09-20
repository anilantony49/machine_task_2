import 'package:flutter/material.dart';
import 'package:machine_task_2/provider/driver_home_provider.dart';
import 'package:machine_task_2/screens/driver/route_detail_screen_one.dart';
import 'package:machine_task_2/screens/user_sign_in/widgets/user_sign_in_page.dart';
import 'package:machine_task_2/services/authentication.dart';
import 'package:machine_task_2/utils/alerts_and_navigate.dart';
import 'package:provider/provider.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  // String? driverName;
  // RouteModels? driverRoute;
  // bool isLoading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   _getDriverDetails();
  // }

  // Future<void> _getDriverDetails() async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;

  //     if (user != null) {
  //       // Fetch driver data from Firestore
  //       final doc = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(user.uid)
  //           .get();

  //       if (doc.exists && doc.data() != null) {
  //         setState(() {
  //           driverName = doc.data()!['name'];
  //         });

  //         // Fetch route from Hive based on the driver name
  //         List<RouteModels> routes = await RouteDb.singleton.getRoutes();
  //         driverRoute = routes.firstWhere(
  //           (route) => route.driver.name == driverName,
  //           // orElse: () => RouteModels(
  //           //     id: '', name: '', driver: null, stores: []), // fallback route
  //         );

  //         setState(() {
  //           isLoading = false;
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     print("Error fetching driver's route: $e");
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<DriverHomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Home'),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
              onPressed: () {
                _showLogoutConfirmationDialog(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  'Log Out',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ))
        ],
      ),
      body: driverProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the button vertically
                children: [
                  Text(
                    'Welcome ${driverProvider.driverName}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      if (driverProvider.driverRoute != null) {
                        nextScreen(
                          context,
                          RouteDetailScreenOne(
                              route: driverProvider.driverRoute!),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No route assigned to the driver'),
                          ),
                        );
                      }
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

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Log Out"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthService().signout();
                nextScreenReplacement(
                    context, UserSignInPage()); // Close the dialog
                // _logOut(context); // Call the logout function
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Log Out"),
            ),
          ],
        );
      },
    );
  }
}
