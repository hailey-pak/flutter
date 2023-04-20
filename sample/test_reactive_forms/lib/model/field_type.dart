import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum FieldType {
  textField(code: 0),
  numberTextField(code: 1),
  dropDown(code: 2),
  checkBox(code: 3),
  radioButton(code: 4),
  switchButton(code: 5),
  slider(code: 6),
  datePicker(code: 7),
  timePicker(code: 8);

  final int code;

  const FieldType({
    required this.code,
  });



  factory FieldType.getByCode(int code) {
    return FieldType.values.firstWhere((val) => val.code == code,
        orElse: () => FieldType.textField);
  }

}
