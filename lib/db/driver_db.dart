import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:machine_task_2/models/driver.dart';

const _dbName = 'driverBox';

abstract class DriverDbFunctions {
  Future<List<DriverModels>> getDrivers();
  Future<void> addDriver(DriverModels value);
  Future<void> deleteDriver(String driverId);
  Future<DriverModels?> getCurrentDriver(String driverId);
  Future<void> editDriver(DriverModels value, String driverId);
  Future<bool?> driverExists(String driverName);
}

class DriverDb implements DriverDbFunctions {
  ValueNotifier<List<DriverModels>> driverNotifier = ValueNotifier([]);

  DriverDb._internal();
  static final DriverDb singleton = DriverDb._internal();

  factory DriverDb() {
    return singleton;
  }

  Future<void> refresh() async {
    final allCountry = await getDrivers();
    driverNotifier.value = List.from(allCountry);
  }

  @override
  Future<void> addDriver(DriverModels value) async {
    final db = await Hive.openBox<DriverModels>(_dbName);
    await db.put(value.id, value);
    refresh();
  }

  @override
  Future<void> deleteDriver(String driverId) async {
    final db = await Hive.openBox<DriverModels>(_dbName);
    await db.delete(driverId);
  }

  @override
  Future<bool?> driverExists(String driverName) async {
    final db = await Hive.openBox<DriverModels>(_dbName);
    final List<DriverModels> allUsers = db.values.toList();

    // Check if any user has the provided username
    return allUsers.any((user) => user.name == driverName);
  }

  @override
  Future<void> editDriver(DriverModels value, String driverId) async {
    final db = await Hive.openBox<DriverModels>(_dbName);
    await db.put(driverId, value);
    refresh();
  }

  @override
  Future<DriverModels?> getCurrentDriver(String driverId) async {
    final db = await Hive.openBox<DriverModels>(_dbName);
    final user = db.get(driverId);
    return user;
  }

  @override
  Future<List<DriverModels>> getDrivers() async {
    final db = await Hive.openBox<DriverModels>(_dbName);
    return db.values.toList();
  }
}
