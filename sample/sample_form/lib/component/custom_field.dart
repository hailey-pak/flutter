import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class CustomField extends StatelessWidget {
  final Type fieldType;
  final String name; //데이터명
  final String labelText; //라벨
  final FormFieldValidator? validator; //유효성체크
  final dynamic initialValue; //초기값
  final DateTime? firstDate;
  final DateTime? lastDate;

  const CustomField({
    required this.fieldType,
    required this.name,
    required this.labelText,
    this.validator,
    this.initialValue,
    this.firstDate,
    this.lastDate,
    Key? key,
  }) : super(key: key);

  factory CustomField.textField({
    required String name,
    required String labelText,
    FormFieldValidator? validator,
    String? initialValue,
  }) {
    return CustomField(
      fieldType: FormBuilderTextField,
      name: name,
      labelText: labelText,
      validator: validator,
      initialValue: initialValue,
    );
  }

  factory CustomField.integerTextField({
    required String name,
    required String labelText,
    FormFieldValidator? validator,
    int? initialValue,
  }) {
    return CustomField(
      fieldType: FormBuilderTextField,
      name: name,
      labelText: labelText,
      validator: validator,
      initialValue: initialValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (fieldType) {
      case FormBuilderCheckbox:
        return FormBuilderCheckbox(
          name: name,
          title: Text(labelText),
          validator: validator,
          initialValue: initialValue,
        );
      case FormBuilderDateTimePicker:
        return FormBuilderDateTimePicker(
          name: name,
          format: DateFormat('yyyy-MM-dd'),
          initialEntryMode: DatePickerEntryMode.calendar,
          initialValue: initialValue ?? DateTime.now(),
          decoration: InputDecoration(
            labelText: labelText,
          ),
        );
      case FormBuilderDateRangePicker:
        return FormBuilderDateRangePicker(
          name: name,
          firstDate: firstDate!,
          lastDate: lastDate!,
        );

      default:
    }

    return FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.integer(),
      ]),
      initialValue: initialValue,
    );
  }
}
