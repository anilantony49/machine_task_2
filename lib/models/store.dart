import 'package:hive/hive.dart';
part 'store.g.dart';

@HiveType(typeId: 4)
class StoreModels {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String address;
  @HiveField(3)
  final String contact;
  @HiveField(4)
  final String? image;

  StoreModels(
      {required this.id,
      required this.name,
      required this.address,
      required this.contact,
      this.image});
}
