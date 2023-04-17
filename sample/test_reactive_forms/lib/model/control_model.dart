import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:test_reactive_forms/main.dart';
import 'package:test_reactive_forms/model/code_model.dart';
import 'package:test_reactive_forms/model/column_def.dart';

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

class ControlModel {
  final ColumnDefinition column;
  final ControlType type;
  final Map<Validators, String>? validations;

  ControlModel({
    required this.column,
    required this.type,
    this.validations,
  });

  Widget renderField() {
    switch (type) {
      case ControlType.TextField:
        return ReactiveTextField(
          formControlName: column.columnName,
          decoration: InputDecoration(
            labelText: column.labelText,
          ),
          readOnly: column.readOnly,
        );

      case ControlType.DropDown:
        String codeId = column.codeId!;
        Box box = Hive.box(codeBox);
        List<CodeModel> codeList = box.get(codeId);

        return ReactiveDropdownField(
          formControlName: column.columnName,
          decoration: InputDecoration(
            labelText: column.labelText,
          ),
          items: makeDropMenuItems(codeList),
        );

      // case ControlType.Radio:
      //   return ReactiveRadioListTile(
      //     formControlName: column.columnName,
      //     value: value,
      //     title: Text(column.labelText),
      //   );

      case ControlType.CheckBox:
        return ReactiveCheckboxListTile(
          formControlName: column.columnName,
          title: Text(column.labelText),
        );

      case ControlType.Switch:
        return ReactiveSwitchListTile(
          formControlName: column.columnName,
          title: Text(column.labelText),
        );

      case ControlType.DatePicker:
        return ReactiveTextField(
          formControlName: column.columnName,
          readOnly: true,
          decoration: InputDecoration(
            labelText: column.labelText,
            suffixIcon: ReactiveDatePicker<DateTime>(
              formControlName: column.columnName,
              firstDate: column.firstDate ?? DateTime(1985),
              lastDate: column.lastDate ?? DateTime(DateTime.now().year + 10),
              builder: (context, picker, child) {
                return IconButton(
                  onPressed: picker.showPicker,
                  icon: const Icon(Icons.date_range),
                );
              },
            ),
          ),
        );

      case ControlType.TimePicker:
        return ReactiveTextField(
          formControlName: column.columnName,
          readOnly: true,
          decoration: InputDecoration(
              labelText: column.labelText,
              suffixIcon: ReactiveTimePicker(
                formControlName: column.columnName,
                builder: (context, picker, child) {
                  return IconButton(
                    onPressed: picker.showPicker,
                    icon: const Icon(Icons.access_time),
                  );
                },
              )),
        );

      default:
        return ReactiveTextField(
          formControlName: column.columnName,
          decoration: InputDecoration(
            labelText: column.labelText,
          ),
          readOnly: column.readOnly,
        );
    }
  }


  List<DropdownMenuItem> makeDropMenuItems(List<CodeModel> codeList) {
    return codeList.map((e) =>
        DropdownMenuItem(
          value: e.code,
          child: Text(e.name),
        ),
    ).toList();
  }

}
