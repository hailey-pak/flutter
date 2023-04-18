// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CodeModelAdapter extends TypeAdapter<CodeModel> {
  @override
  final int typeId = 0;

  @override
  CodeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CodeModel(
      codeId: fields[0] as String,
      code: fields[1] as dynamic,
      name: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CodeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.codeId)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CodeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
