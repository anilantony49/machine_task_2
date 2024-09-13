import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:machine_task_2/models/store.dart';

const _dbName = 'retailShopBox';

abstract class RetailShopDbFunctions {
  Future<List<StoreModels>> getretailShops();
  Future<void> addretailShop(StoreModels value);
  Future<void> deleteretailShop(String retailShopId);
  Future<StoreModels?> getCurrentretailShop(String retailShopId);
  Future<void> editretailShop(StoreModels value, String retailShopId);
  Future<bool?> retailShopExists(String retailShopName);
}

class RetailShopDb implements RetailShopDbFunctions {
  ValueNotifier<List<StoreModels>> retailShopNotifier = ValueNotifier([]);

  RetailShopDb._internal();
  static final RetailShopDb singleton = RetailShopDb._internal();

  factory RetailShopDb() {
    return singleton;
  }

  Future<void> refresh() async {
    final allCountry = await getretailShops();
    retailShopNotifier.value = List.from(allCountry);
  }

  @override
  Future<void> addretailShop(StoreModels value) async {
    final db = await Hive.openBox<StoreModels>(_dbName);
    await db.put(value.id, value);
    refresh();
  }

  @override
  Future<void> deleteretailShop(String retailShopId) async {
    final db = await Hive.openBox<StoreModels>(_dbName);
    await db.delete(retailShopId);
  }

  @override
  Future<bool?> retailShopExists(String retailShopName) async {
    final db = await Hive.openBox<StoreModels>(_dbName);
    final List<StoreModels> allUsers = db.values.toList();

    // Check if any user has the provided username
    return allUsers.any((user) => user.name == retailShopName);
  }

  @override
  Future<void> editretailShop(StoreModels value, String retailShopId) async {
    final db = await Hive.openBox<StoreModels>(_dbName);
    await db.put(retailShopId, value);
    refresh();
  }

  @override
  Future<StoreModels?> getCurrentretailShop(String retailShopId) async {
    final db = await Hive.openBox<StoreModels>(_dbName);
    final user = db.get(retailShopId);
    return user;
  }

  @override
  Future<List<StoreModels>> getretailShops() async {
    final db = await Hive.openBox<StoreModels>(_dbName);
    return db.values.toList();
  }
}
