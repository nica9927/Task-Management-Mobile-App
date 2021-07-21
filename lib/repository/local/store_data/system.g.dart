// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreSystemDataAdapter extends TypeAdapter<StoreSystemData> {
  @override
  final int typeId = 1;

  @override
  StoreSystemData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreSystemData()
      ..apiToken = fields[0] as String?
      ..refreshToken = fields[1] as String?
      ..companyID = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, StoreSystemData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.apiToken)
      ..writeByte(1)
      ..write(obj.refreshToken)
      ..writeByte(2)
      ..write(obj.companyID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreSystemDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
