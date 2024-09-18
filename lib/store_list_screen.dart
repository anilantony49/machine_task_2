import 'package:flutter/material.dart';
import 'package:machine_task_2/models/store.dart';

class StoreListScreen extends StatelessWidget {
  final List<StoreModels> stores = [
    // StoreModels(
    //     id: '1', name: 'Store A', address: '123 Main St', group: 'Group 1'),
    // StoreModels(
    //     id: '2', name: 'Store B', address: '456 Elm St', group: 'Group 2'),
  ];

  StoreListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (context, index) {
        final store = stores[index];
        return ListTile(
          title: Text(store.name),
          subtitle: Text('Address: ${store.address}'),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit store page
            },
          ),
        );
      },
    );
  }
}
