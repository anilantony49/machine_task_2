import 'package:flutter/material.dart';
import 'package:machine_task_2/db/driver_db.dart';
import 'package:machine_task_2/models/driver.dart';

class DriverProvider extends ChangeNotifier {
  List<DriverModels> drivers = [];

  DriverProvider() {
    fetchDriver();
  }

  Future<void> fetchDriver() async {
    List<DriverModels> fetchedItems = await DriverDb.singleton.getDrivers();
    drivers = fetchedItems;
    notifyListeners();
  }

  Future<void> addOrEditDriver(DriverModels? store) async {
    // Logic to add or edit store in the database
    await fetchDriver(); // Fetch updated store list after the operation
  }

  Future<void> deleteDriver(DriverModels store) async {
    // Logic to delete store from the database
    await fetchDriver(); // Fetch updated store list after deletion
  }
}
