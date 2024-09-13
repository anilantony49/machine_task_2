import 'package:hive/hive.dart';
import 'package:machine_task_2/models/driver.dart';
import 'package:machine_task_2/models/store.dart';
part 'route.g.dart';

@HiveType(typeId: 3)
class RouteModels {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final DriverModels driver;
  @HiveField(3)
  final List<StoreModels> stores;

  RouteModels(
      {required this.id,
      required this.name,
      required this.driver,
      required this.stores});
}
