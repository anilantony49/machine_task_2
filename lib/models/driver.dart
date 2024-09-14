import 'package:hive/hive.dart';
part 'driver.g.dart';

@HiveType(typeId: 2)
class DriverModels {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String contact;
  @HiveField(3)
  final String age;
  @HiveField(4)
  final String? image;

  DriverModels(
      {required this.id,
      required this.name,
      required this.contact,
      required this.age,
      this.image});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is DriverModels && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
