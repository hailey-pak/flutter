import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sample_form/component/custom_field.dart';

class DataForm extends StatelessWidget {
  const DataForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

    return FormBuilder(
      key: formKey,
      child: Column(
        children: const [
          CustomField(
            fieldType: FormBuilderTextField,
            name: 'name',
            labelText: '이름',
          ),
          CustomField(
            fieldType: FormBuilderTextField,
            name: 'id',
            labelText: '아이디',
          ),
          CustomField(
            fieldType: FormBuilderCheckbox,
            name: 'check',
            labelText: '체크',
          ),
          CustomField(
            fieldType: FormBuilderDateTimePicker,
            name: 'date',
            labelText: '날짜',
          ),

        ],
      ),
    );
  }
}
