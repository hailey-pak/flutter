
class ColumnDefinition {
  final String tableId;
  final String columnName;
  final String labelText;
  final String valueType;
  final bool readOnly;

  String? codeId;
  DateTime? firstDate;
  DateTime? lastDate;

  ColumnDefinition({
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