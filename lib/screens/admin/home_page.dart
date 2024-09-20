import 'package:flutter/material.dart';
import 'package:machine_task_2/screens/admin/route_management_screen.dart';
import 'package:machine_task_2/services/authentication.dart';
import 'package:machine_task_2/screens/user_sign_in/sign_in_screen.dart';

import 'package:machine_task_2/screens/admin/widget/tab_bar_widget.dart';
import 'package:machine_task_2/utils/alerts_and_navigate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFF0),
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
                nextScreenReplacement(
                    context,  UserSignInPage()); // Close the dialog
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
