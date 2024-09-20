import 'package:flutter/material.dart';
import 'package:machine_task_2/db/retail_shop_db.dart';
import 'package:machine_task_2/models/store.dart';

void showDeleteConfirmationDialog(
    BuildContext context, StoreModels store, Function fetchStore) {
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
              await StoreDb.singleton.deleteStore(store.id);

              // widget.refreshDrivers(); // Refresh the list after deletion
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              fetchStore(); // Close the dialog after deletion
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
