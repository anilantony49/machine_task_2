import 'package:flutter/material.dart';
import 'package:machine_task_2/route_management_screen.dart';
import 'package:machine_task_2/services/authentication.dart';
import 'package:machine_task_2/sign_in_screen.dart';

import 'package:machine_task_2/tab_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This function will refresh the drivers list when called
  @override
  Widget build(BuildContext context) {
    // AuthService _auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Driver and Store Management',
          style: TextStyle(
            fontSize: 18, // Text size
            color: Colors.white, // Text color
            fontWeight: FontWeight.bold, // Bold text
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton(
            onSelected: (String result) {
              if (result == 'route_management') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const RouteManagementPage(), // Navigate to NewPage
                  ),
                );
              } else if (result == 'logout') {
                _showLogoutConfirmationDialog(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'route_management',
                child: Text('Route Management'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Log Out'),
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: const [
          SizedBox(
            height: 20,
          ),
          TabViewWidget()
        ],
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        UserSignInPage())); // Close the dialog
                // _logOut(context); // Call the logout function
              },
              child: const Text("Log Out"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }
}
