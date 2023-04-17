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

    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: renderWidgets(),
      ),
    );
  }

  List<Widget> renderWidgets() {
    List<Widget> list = fields.map((field) => field.renderField()).toList();
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
