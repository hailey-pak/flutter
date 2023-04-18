// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emd_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmdModelAdapter extends TypeAdapter<EmdModel> {
  @override
  final int typeId = 100;

  @override
  EmdModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmdModel(
      input_fid: fields[0] as String,
      emd_cd: fields[1] as String,
      emd_nm: fields[2] as String,
      ssg_oid: fields[3] as int,
      col_adm_se: fields[4] as String,
      gid: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, EmdModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.input_fid)
      ..writeByte(1)
      ..write(obj.emd_cd)
      ..writeByte(2)
      ..write(obj.emd_nm)
      ..writeByte(3)
      ..write(obj.ssg_oid)
      ..writeByte(4)
      ..write(obj.col_adm_se)
      ..writeByte(5)
      ..write(obj.gid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmdModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
