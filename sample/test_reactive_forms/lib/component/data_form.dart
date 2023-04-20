import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:test_reactive_forms/model/field_model.dart';
import 'package:test_reactive_forms/model/data_model.dart';

class DataForm extends StatelessWidget {
  final IDataModel dataModel;

  const DataForm({
    required this.dataModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<FieldModel> fieldModels = dataModel.getFields();

    // 폼 그룹 생성
    // Map<String, Object> controls = {};
    // for (FieldModel field in fieldModels) {
    //   String colName = field.column.columnName;
    //   controls[colName] = [dataModel.getValue(colName)];
    // }

    // final form = fb.group(controls);

    Map<String, AbstractControl<dynamic>> controls = {};
    for (FieldModel field in fieldModels) {
        String colName = field.column.columnName;
        controls[colName] = field.getFormControl(initialValue: dataModel.getValue(colName));
    }
    final FormGroup form = FormGroup(controls);

    return ReactiveForm(
      formGroup: form,
      child: Column(
        children:
          renderWidgets(fieldModels),
      ),
    );
  }

  List<Widget> renderWidgets(List<FieldModel> fieldModels) {
    List<Widget> list =
        fieldModels.map((field) => field.renderField()).toList();
    list.add(
      ReactiveFormConsumer(
        builder: (context, form, child) {
          return ElevatedButton(
            onPressed: () {
              if (form.valid) {
                print(form.value);
              }
            },
            child: const Text('저장'),
          );
        },
      ),
    );
    return list;
  }

}
