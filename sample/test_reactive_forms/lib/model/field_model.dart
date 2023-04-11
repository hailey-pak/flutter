import 'package:flutter/material.dart';

enum ControlType {
  TextField,
  DropDown,
  Radio,
  CheckBox,
  Switch,
  Slider,
  DatePicker,
  TimePicker,
}

class FieldModel {
  final String columnName;
  final String labelText;
  final ControlType controlType;
  final Type valueType;
  final bool readOnly;

  List<DropdownMenuItem>? items;

  FieldModel({
    required this.columnName,
    required this.labelText,
    required this.controlType,
    required this.valueType,
    required this.readOnly,
    this.items,
  });


}
