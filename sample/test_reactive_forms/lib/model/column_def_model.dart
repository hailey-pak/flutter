
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
  final String valueType;
  @HiveField(4)
  final bool readOnly;

  @HiveField(5)
  String? codeId;
  @HiveField(6)
  DateTime? firstDate;
  @HiveField(7)
  DateTime? lastDate;

  ColumnDefinitionModel({
    required this.tableId,
    required this.columnName,
    required this.labelText,
    required this.valueType,
    required this.readOnly,
    this.codeId,
    this.firstDate,
    this.lastDate,
  });

}