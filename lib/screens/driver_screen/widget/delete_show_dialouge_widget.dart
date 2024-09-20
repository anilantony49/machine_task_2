import 'package:flutter/material.dart';
import 'package:machine_task_2/db/driver_db.dart';
import 'package:machine_task_2/models/driver.dart';

void showDeleteConfirmationDialog(
    BuildContext context, DriverModels driver, Function fetchDriver) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete Driver"),
        content: const Text("Are you sure you want to delete this driver?"),
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
              await DriverDb.singleton.deleteDriver(driver.id);

              // widget.refreshDrivers(); // Refresh the list after deletion
              Navigator.of(context).pop();
              fetchDriver(); // Close the dialog after deletion
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Driver deleted successfully')),
              );
            },
            child: const Text("Delete"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      );
    },
  );
}
