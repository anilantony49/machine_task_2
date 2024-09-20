import 'package:flutter/material.dart';
import 'package:machine_task_2/db/retail_shop_db.dart';
import 'package:machine_task_2/models/store.dart';

class RetailShopProvider extends ChangeNotifier {
  List<StoreModels> stores = [];

  RetailShopProvider() {
    fetchStore();
  }

  Future<void> fetchStore() async {
    List<StoreModels> fetchedItems = await StoreDb.singleton.getStore();
    stores = fetchedItems;
    notifyListeners();
  }

  Future<void> addOrEditStore(StoreModels? store) async {
    // Logic to add or edit store in the database
    await fetchStore(); // Fetch updated store list after the operation
  }

  Future<void> deleteStore(StoreModels store) async {
    // Logic to delete store from the database
    await fetchStore(); // Fetch updated store list after deletion
  }
}
