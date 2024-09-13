// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreModelsAdapter extends TypeAdapter<StoreModels> {
  @override
  final int typeId = 4;

  @override
  StoreModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreModels(
      id: fields[0] as String,
      name: fields[1] as String,
      address: fields[2] as String,
      contact: fields[3] as String,
      image: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StoreModels obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.contact)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
