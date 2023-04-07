import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomField extends StatelessWidget {
  final String controlName;
  final String labelText;
  final bool readOnly;

  const CustomField({
    required this.controlName,
    required this.labelText,
    required this.readOnly,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: controlName,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
