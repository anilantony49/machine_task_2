import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:machine_task_2/models/route.dart';

const _dbName = 'routeBox';

abstract class RouteFunctions {
  Future<List<RouteModels>> getRoutes();
  Future<void> addRoute(RouteModels value);
  Future<void> deleteRoute(String routeId);
  Future<RouteModels?> getCurrentRoute(String routeId);
  Future<void> editRoute(RouteModels value, String routeId);
  Future<bool?> routeExists(String routeName);
}

class RouteDb implements RouteFunctions {
  ValueNotifier<List<RouteModels>> routeNotifier = ValueNotifier([]);

  RouteDb._internal();
  static final RouteDb singleton = RouteDb._internal();

  factory RouteDb() {
    return singleton;
  }

  Future<void> refresh() async {
    final allroute = await getRoutes();
    routeNotifier.value = List.from(allroute);
  }

  @override
  Future<void> addRoute(RouteModels value) async {
    final db = await Hive.openBox<RouteModels>(_dbName);
    await db.put(value.id, value);
    refresh();
  }

  @override
  Future<void> deleteRoute(String routeId) async {
    final db = await Hive.openBox<RouteModels>(_dbName);
    await db.delete(routeId);
  }

  @override
  Future<bool?> routeExists(String routeName) async {
    final db = await Hive.openBox<RouteModels>(_dbName);
    final List<RouteModels> allUsers = db.values.toList();

    // Check if any user has the provided username
    return allUsers.any((route) => route.name == routeName);
  }

  @override
  Future<void> editRoute(RouteModels value, String routeId) async {
    final db = await Hive.openBox<RouteModels>(_dbName);
    await db.put(routeId, value);
    refresh();
  }

  @override
  Future<RouteModels?> getCurrentRoute(String routeId) async {
    final db = await Hive.openBox<RouteModels>(_dbName);
    final user = db.get(routeId);
    return user;
  }

  @override
  Future<List<RouteModels>> getRoutes() async {
    final db = await Hive.openBox<RouteModels>(_dbName);
    return db.values.toList();
  }
}
