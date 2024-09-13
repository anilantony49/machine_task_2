import 'package:flutter/material.dart';
import 'package:machine_task_2/route_management_screen.dart';

import 'package:machine_task_2/tab_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This function will refresh the drivers list when called
  @override
  Widget build(BuildContext context) {
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
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RouteManagementPage(), // Navigate to NewPage
                  ),
                );
              },
              icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: ListView(
        children: const [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TabViewWidget()
            ],
          )
        ],
      ),
    );
  }
}
