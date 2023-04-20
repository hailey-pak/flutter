import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:test_reactive_forms/main.dart';
import 'package:test_reactive_forms/model/code_model.dart';
import 'package:test_reactive_forms/model/column_def_model.dart';
import 'package:test_reactive_forms/model/field_type.dart';

class FieldModel {
  final ColumnDefinitionModel column;
  List<ValidatorFunction>? validators;
  Map<String, ValidationMessageFunction>? validationMessages;
  List<AsyncValidatorFunction>? asyncValidators;

  FieldModel({
    required this.column,
    this.validators,
    this.validationMessages,
    this.asyncValidators,
  });


  FormControl getFormControl({
    required dynamic initialValue,
  }) {
    validators ??= [];
    asyncValidators ??= [];

    // required 조건 추가
    if (column.required) {
      validators!.add(Validators.required);
    }

    return FormControl(
      value: initialValue,
      validators: validators!,
      asyncValidators: asyncValidators!,
    );
  }

  Widget renderField() {
    validationMessages ??= {};

    // required 조건 추가
    if (column.required) {
      validationMessages!.putIfAbsent(
        ValidationMessage.required,
            () {
          return (error) => '필수로 입력해주세요.';
        },
      );
    }

    FieldType type = FieldType.getByCode(column.fieldType);

    switch (type) {
      case FieldType.textField:
        return ReactiveTextField(
          formControlName: column.columnName,
          decoration: InputDecoration(
            labelText: column.labelText,
          ),
          readOnly: column.readOnly,
          validationMessages: validationMessages,
        );

      case FieldType.numberTextField:
        validationMessages!.putIfAbsent(
          ValidationMessage.number,
              () {
            return (error) => '숫자만 입력할 수 있습니다.';
          },
        );

        return ReactiveTextField(
          formControlName: column.columnName,
          decoration: InputDecoration(
            labelText: column.labelText,
          ),
          readOnly: column.readOnly,
          validationMessages: validationMessages,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        );

      case FieldType.dropDown:
      // 드롭다운 메뉴에 들어갈 값 리스트
        List<CodeModel> codeList = [];
        if (column.codeId != null) {
          String codeId = column.codeId!;
          final box = Hive.box(codeBox);
          codeList = List<CodeModel>.from(box.get(codeId));
        }

        return ReactiveDropdownField(
          formControlName: column.columnName,
          decoration: InputDecoration(
            labelText: column.labelText,
          ),
          items: makeDropMenuItems(codeList),
        );

      case FieldType.checkBox:
        return ReactiveCheckboxListTile(
          formControlName: column.columnName,
          title: Text(column.labelText),
        );

      case FieldType.radioButton:
        return ReactiveRadioListTile(
          formControlName: column.columnName,
          value: true,
          title: Text(column.labelText),
        );

      case FieldType.switchButton:
        return ReactiveSwitchListTile(
          formControlName: column.columnName,
          title: Text(column.labelText),
        );

      case FieldType.datePicker:
        return ReactiveTextField(
          formControlName: column.columnName,
          readOnly: true,
          decoration: InputDecoration(
            labelText: column.labelText,
            suffixIcon: ReactiveDatePicker<DateTime>(
              formControlName: column.columnName,
              firstDate: column.firstDate ?? DateTime(1985),
              lastDate: column.lastDate ?? DateTime(DateTime
                  .now()
                  .year + 10),
              builder: (context, picker, child) {
                return IconButton(
                  onPressed: picker.showPicker,
                  icon: const Icon(Icons.date_range),
                );
              },
            ),
          ),
        );

      case FieldType.timePicker:
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
          validationMessages: validationMessages,
        );
    }
  }

  List<DropdownMenuItem> makeDropMenuItems(List<CodeModel> codeList) {
    return codeList
        .map(
          (e) =>
          DropdownMenuItem(
            value: e.code,
            child: Text(e.name),
          ),
    )
        .toList();
  }
}
