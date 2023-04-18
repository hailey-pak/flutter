// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_map_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BaseMapModelAdapter extends TypeAdapter<BaseMapModel> {
  @override
  final int typeId = 101;

  @override
  BaseMapModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BaseMapModel(
      ueepnu: fields[0] as String,
      gakuka: fields[1] as double,
      gimok: fields[2] as int,
      giyuk: fields[3] as int,
      dist: fields[4] as int?,
      gita: fields[5] as int?,
      yongdo: fields[6] as int,
      area: fields[7] as double,
      jibun: fields[8] as String,
      shape_leng: fields[9] as double,
      shape_area: fields[10] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BaseMapModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.ueepnu)
      ..writeByte(1)
      ..write(obj.gakuka)
      ..writeByte(2)
      ..write(obj.gimok)
      ..writeByte(3)
      ..write(obj.giyuk)
      ..writeByte(4)
      ..write(obj.dist)
      ..writeByte(5)
      ..write(obj.gita)
      ..writeByte(6)
      ..write(obj.yongdo)
      ..writeByte(7)
      ..write(obj.area)
      ..writeByte(8)
      ..write(obj.jibun)
      ..writeByte(9)
      ..write(obj.shape_leng)
      ..writeByte(10)
      ..write(obj.shape_area);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseMapModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
