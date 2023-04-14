import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

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

  List<DropdownMenuItem>? items; // dropdown 컨트롤에 설정할 메뉴 아이템 리스트
  dynamic value; //
  DateTime? firstDate;
  DateTime? lastDate;

  FieldModel({
    required this.columnName,
    required this.labelText,
    required this.controlType,
    required this.valueType,
    required this.readOnly,
    this.items,
    this.firstDate,
    this.lastDate,
  });

  Widget renderField() {
    switch (controlType) {
      case ControlType.TextField:
        return ReactiveTextField(
          formControlName: columnName,
          decoration: InputDecoration(
            labelText: labelText,
          ),
          readOnly: readOnly,
        );

      case ControlType.DropDown:
        return ReactiveDropdownField(
          formControlName: columnName,
          decoration: InputDecoration(
            labelText: labelText,
          ),
          items: items!,
        );

      case ControlType.Radio:
        return ReactiveRadioListTile(
          formControlName: columnName,
          value: value,
          title: Text(labelText),
        );

      case ControlType.CheckBox:
        return ReactiveCheckboxListTile(
          formControlName: columnName,
          title: Text(labelText),
        );

      case ControlType.Switch:
        return ReactiveSwitchListTile(
          formControlName: columnName,
          title: Text(labelText),
        );

      case ControlType.DatePicker:
        return ReactiveTextField(
          formControlName: columnName,
          readOnly: true,
          decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: ReactiveDatePicker<DateTime>(
              formControlName: columnName,
              firstDate: firstDate ?? DateTime(1985),
              lastDate: lastDate ?? DateTime(DateTime.now().year + 10),
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
          formControlName: columnName,
          readOnly: true,
          decoration: InputDecoration(
              labelText: labelText,
              suffixIcon: ReactiveTimePicker(
                formControlName: columnName,
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
          formControlName: columnName,
          decoration: InputDecoration(
            labelText: labelText,
          ),
          readOnly: readOnly,
        );
    }
  }
}
