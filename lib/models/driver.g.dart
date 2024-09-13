// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DriverModelsAdapter extends TypeAdapter<DriverModels> {
  @override
  final int typeId = 2;

  @override
  DriverModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DriverModels(
      id: fields[0] as String,
      name: fields[1] as String,
      contact: fields[2] as String,
      age: fields[3] as String,
      image: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DriverModels obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.contact)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
