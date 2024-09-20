import 'package:flutter/material.dart';
import 'package:machine_task_2/db/route_db.dart';
import 'package:machine_task_2/models/route.dart';

void showDeleteConfirmationDialog(
    BuildContext context, RouteModels routes, Function fetchRoute) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete Route"),
        content: const Text("Are you sure you want to delete this Route?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              // Perform the delete operation
              await RouteDb.singleton.deleteRoute(routes.id);

              // widget.refreshDrivers(); // Refresh the list after deletion
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              fetchRoute(); // Close the dialog after deletion
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Driver deleted successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}
