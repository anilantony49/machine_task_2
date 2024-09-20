import 'package:flutter/material.dart';
import 'package:machine_task_2/db/driver_db.dart';
import 'package:machine_task_2/db/route_db.dart';
import 'package:machine_task_2/db/retail_shop_db.dart';
import '../models/route.dart';
import '../models/driver.dart';
import '../models/store.dart';

class RouteProvider with ChangeNotifier {
  List<RouteModels> _routes = [];
  List<RouteModels> get routes => _routes;

  Future<void> fetchRoutes() async {
    _routes = await RouteDb.singleton.getRoutes();
    notifyListeners();
  }

  Future<void> addRoute(RouteModels route) async {
    await RouteDb.singleton.addRoute(route);
    await fetchRoutes();
  }

  Future<void> editRoute(RouteModels route, String id) async {
    await RouteDb.singleton.editRoute(route, id);
    await fetchRoutes();
  }
}

class DriverProvider with ChangeNotifier {
  List<DriverModels> _drivers = [];
  List<DriverModels> get drivers => _drivers;

  Future<void> fetchDrivers() async {
    _drivers = await DriverDb.singleton.getDrivers();
    _drivers.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    notifyListeners();
  }
}

class StoreProvider with ChangeNotifier {
  List<StoreModels> _stores = [];
  List<StoreModels> get stores => _stores;

  Future<void> fetchStores() async {
    _stores = await StoreDb.singleton.getStore();
    _stores.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    notifyListeners();
  }
}
