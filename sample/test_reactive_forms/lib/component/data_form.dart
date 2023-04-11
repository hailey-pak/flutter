import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:test_reactive_forms/main.dart';
import 'package:test_reactive_forms/model/emd_model.dart';
import 'package:test_reactive_forms/model/field_model.dart';

class DataForm extends StatelessWidget {
  final List<FieldModel> fields;
  final String fid; // 폼에 보여줄 데이터의 id 값

  const DataForm({
    required this.fields,
    required this.fid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Box<EmdModel> box = Hive.box(emdBox);
    final EmdModel? model = box.get(fid);

    Map<String, Object> controls = {};
    for (FieldModel field in fields) {
      controls[field.columnName] = [model?.getValueFromName(field.columnName)];
    }

    final form = fb.group(controls);

    /* final form = fb.group({
      'INPUT_FID': FormControl<String>(
        value: model?.getValue(0),
        disabled: true,
      ),
      'EMD_CD': FormControl<String>(
        value: model?.getValue(1),
        disabled: true,
      ),
      'EMD_NM': FormControl<String>(
        value: model?.getValue(2),
        validators: [Validators.required],
      ),
      'SGG_OID': FormControl<int>(
        value: model?.getValue(3),
        validators: [Validators.required, Validators.number],
      ),
      'COL_ADM_SE': FormControl<String>(
        value: model?.getValue(4),
        validators: [Validators.required],
      ),
      'GID': FormControl<int>(
        value: model?.getValue(5),
        validators: [Validators.required, Validators.number],
      ),
    });*/

    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: fields.map((field) => renderField(field)).toList(),
/*        [
          ReactiveTextField<String>(
            formControlName: 'INPUT_FID',
            decoration: InputDecoration(
              labelText: 'INPUT_FID의 라벨',
            ),
          ),
          const SizedBox(height: 16.0),
          ReactiveTextField<String>(
            formControlName: 'EMD_CD',
            decoration: InputDecoration(
              labelText: 'EMD_CD의 라벨',
            ),
          ),
          const SizedBox(height: 16.0),
          ReactiveTextField<String>(
            formControlName: 'EMD_NM',
            decoration: InputDecoration(
              labelText: 'EMD_NM의 라벨',
            ),
          ),
          const SizedBox(height: 16.0),
          ReactiveTextField<int>(
            formControlName: 'SGG_OID',
            decoration: InputDecoration(
              labelText: 'SGG_OID의 라벨',
            ),
          ),
          const SizedBox(height: 16.0),
          ReactiveDropdownField<String>(
            formControlName: 'COL_ADM_SE',
            decoration: InputDecoration(
              labelText: 'COL_ADM_SE의 라벨',
            ),
            items: const [
              DropdownMenuItem(
                value: '50110',
                child: Text('50110'),
              ),
              DropdownMenuItem(
                value: '50120',
                child: Text('50120'),
              ),
              DropdownMenuItem(
                value: '50130',
                child: Text('50130'),
              ),
              DropdownMenuItem(
                value: '50140',
                child: Text('50140'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          ReactiveTextField<int>(
            formControlName: 'GID',
            decoration: InputDecoration(
              labelText: 'GID의 라벨',
            ),
          ),
        ],*/
      ),
    );
  }

  Widget renderField(FieldModel field) {
    switch (field.controlType) {
      case ControlType.TextField:
        return ReactiveTextField(
          formControlName: field.columnName,
          decoration: InputDecoration(
            labelText: field.labelText,
          ),
          readOnly: field.readOnly,
        );
      case ControlType.DropDown:
        return ReactiveDropdownField(
          formControlName: field.columnName,
          decoration: InputDecoration(
            labelText: field.labelText,
          ),
          items: field.items!,
        );
      default:
        return ReactiveTextField(
          formControlName: field.columnName,
          decoration: InputDecoration(
            labelText: field.labelText,
          ),
          readOnly: field.readOnly,
        );
    }
  }
}
