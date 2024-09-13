// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RouteModelsAdapter extends TypeAdapter<RouteModels> {
  @override
  final int typeId = 3;

  @override
  RouteModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RouteModels(
      id: fields[0] as String,
      name: fields[1] as String,
      driver: fields[2] as DriverModels,
      stores: (fields[3] as List).cast<StoreModels>(),
    );
  }

  @override
  void write(BinaryWriter writer, RouteModels obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.driver)
      ..writeByte(3)
      ..write(obj.stores);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
