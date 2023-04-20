// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'column_def_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColumnDefinitionModelAdapter extends TypeAdapter<ColumnDefinitionModel> {
  @override
  final int typeId = 1;

  @override
  ColumnDefinitionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ColumnDefinitionModel(
      tableId: fields[0] as String,
      columnName: fields[1] as String,
      labelText: fields[2] as String,
      fieldType: fields[3] as int,
      required: fields[4] as bool,
      readOnly: fields[5] as bool,
      codeId: fields[6] as String?,
      firstDate: fields[7] as DateTime?,
      lastDate: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ColumnDefinitionModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.tableId)
      ..writeByte(1)
      ..write(obj.columnName)
      ..writeByte(2)
      ..write(obj.labelText)
      ..writeByte(3)
      ..write(obj.fieldType)
      ..writeByte(4)
      ..write(obj.required)
      ..writeByte(5)
      ..write(obj.readOnly)
      ..writeByte(6)
      ..write(obj.codeId)
      ..writeByte(7)
      ..write(obj.firstDate)
      ..writeByte(8)
      ..write(obj.lastDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColumnDefinitionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
