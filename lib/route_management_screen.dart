import 'package:flutter/material.dart';
import 'models/route.dart';
import 'models/driver.dart';
import 'models/store.dart';

class RouteManagementPage extends StatelessWidget {
  final List<DriverModels> drivers = [
    // DriverModels(
    //     id: '1', name: 'John Doe', contact: '123-456-7890', age: 'Truck'),
    // DriverModels(
    //     id: '2', name: 'Jane Smith', contact: '987-654-3210', age: 'Van'),
  ];

  final List<StoreModels> stores = [
    // StoreModels(id: '1', name: 'Store A', address: '123 Main St', group: 'Group 1'),
    // StoreModels(id: '2', name: 'Store B', address: '456 Elm St', group: 'Group 2'),
  ];

  final List<RouteModels> routes = [];

  RouteManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Route Management')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: routes.length,
              itemBuilder: (context, index) {
                final route = routes[index];
                return ListTile(
                  title: Text(route.name),
                  subtitle: Text('Driver: ${route.driver.name}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _showRouteDialog(context, route);
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _showRouteDialog(context, null);
            },
            child: const Text('Add Route'),
          ),
        ],
      ),
    );
  }

  void _showRouteDialog(BuildContext context, RouteModels? route) {
    final isEditing = route != null;
    final routeNameController = TextEditingController(text: route?.name ?? '');
    DriverModels? selectedDriver = route?.driver;
    List<StoreModels> selectedStores = route?.stores ?? [];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Route' : 'Add Route'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: routeNameController,
                decoration: const InputDecoration(labelText: 'Route Name'),
              ),
              DropdownButton<DriverModels>(
                hint: const Text('Select Driver'),
                value: selectedDriver,
                onChanged: (DriverModels? newValue) {
                  selectedDriver = newValue;
                },
                items: drivers.map((DriverModels driver) {
                  return DropdownMenuItem<DriverModels>(
                    value: driver,
                    child: Text(driver.name),
                  );
                }).toList(),
              ),
              // Add your logic to manage stores (e.g., multi-select)
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedDriver != null) {
                  final newRoute = RouteModels(
                    id: isEditing ? route!.id : DateTime.now().toString(),
                    name: routeNameController.text,
                    driver: selectedDriver!,
                    stores: selectedStores,
                  );
                  if (isEditing) {
                    // Update the existing route
                  } else {
                    // Add the new route
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text(isEditing ? 'Update' : 'Add'),
            ),
          ],
        );
      },
    );
  }
}
