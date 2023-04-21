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
      valueType: fields[3] as Type,
      fieldType: fields[4] as int,
      required: fields[5] as bool,
      readOnly: fields[6] as bool,
      codeId: fields[7] as String?,
      firstDate: fields[8] as DateTime?,
      lastDate: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ColumnDefinitionModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.tableId)
      ..writeByte(1)
      ..write(obj.columnName)
      ..writeByte(2)
      ..write(obj.labelText)
      ..writeByte(3)
      ..write(obj.valueType)
      ..writeByte(4)
      ..write(obj.fieldType)
      ..writeByte(5)
      ..write(obj.required)
      ..writeByte(6)
      ..write(obj.readOnly)
      ..writeByte(7)
      ..write(obj.codeId)
      ..writeByte(8)
      ..write(obj.firstDate)
      ..writeByte(9)
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
