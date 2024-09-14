import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:machine_task_2/models/store.dart';

const _dbName = 'storeBox';

abstract class StoreDbFunctions {
  Future<List<StoreModels>> getStore();
  Future<void> addStore(StoreModels value);
  Future<void> deleteStore(String storeId);
  Future<StoreModels?> getCurrentStore(String storeId);
  Future<void> editStore(StoreModels value, String storeId);
  Future<bool?> storeExists(String storeName);
}

class StoreDb implements StoreDbFunctions {
  ValueNotifier<List<StoreModels>> storeNotifier = ValueNotifier([]);

  StoreDb._internal();
  static final StoreDb singleton = StoreDb._internal();

  factory StoreDb() {
    return singleton;
  }

  Future<void> refresh() async {
    final allStore = await getStore();
    storeNotifier.value = List.from(allStore);
  }

  @override
  Future<void> addStore(StoreModels value) async {
    final db = await Hive.openBox<StoreModels>(_dbName);
    await db.put(value.id, value);
    refresh();
  }

  @override
  Future<void> deleteStore(String retailShopId) async {
    final db = await Hive.openBox<StoreModels>(_dbName);
    await db.delete(retailShopId);
  }

  @override
  Future<bool?> storeExists(String storeName) async {
    final db = await Hive.openBox<StoreModels>(_dbName);
    final List<StoreModels> allStores = db.values.toList();

    // Check if any user has the provided username
    return allStores.any((user) => user.name == storeName);
  }

  @override
  Future<void> editStore(StoreModels value, String storeId) async {
    final db = await Hive.openBox<StoreModels>(_dbName);
    await db.put(storeId, value);
    refresh();
  }

  @override
  Future<StoreModels?> getCurrentStore(String storeId) async {
    final db = await Hive.openBox<StoreModels>(_dbName);
    final user = db.get(storeId);
    return user;
  }

  @override
  Future<List<StoreModels>> getStore() async {
    final db = await Hive.openBox<StoreModels>(_dbName);
    return db.values.toList();
  }
}
