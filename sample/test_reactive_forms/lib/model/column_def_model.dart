
import 'package:hive/hive.dart';

part 'column_def_model.g.dart';

@HiveType(typeId: 1)
class ColumnDefinitionModel {
  @HiveField(0)
  final String tableId;
  @HiveField(1)
  final String columnName;
  @HiveField(2)
  final String labelText;
  @HiveField(3)
  final Type valueType;
  @HiveField(4)
  final int fieldType;
  @HiveField(5)
  final bool required;
  @HiveField(6)
  final bool readOnly;

  @HiveField(7)
  String? codeId;
  @HiveField(8)
  DateTime? firstDate;
  @HiveField(9)
  DateTime? lastDate;

  ColumnDefinitionModel({
    required this.tableId,
    required this.columnName,
    required this.labelText,
    required this.valueType,
    required this.fieldType,
    required this.required,
    required this.readOnly,
    this.codeId,
    this.firstDate,
    this.lastDate,
  });

}
