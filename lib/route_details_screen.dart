import 'package:flutter/material.dart';
import 'package:machine_task_2/models/route.dart';

class RouteDetailsScreen extends StatelessWidget {
  final RouteModels route;

  const RouteDetailsScreen({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Route Details'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Route Name: ${route.name}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Driver: ${route.driver.name}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Stores:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...route.stores.map(
              (store) => Text(
                store.name,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
