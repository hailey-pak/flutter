import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DataForm extends StatefulWidget {
  const DataForm({Key? key}) : super(key: key);

  @override
  State<DataForm> createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  final form = fb.group({

  });

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConfig(
      validationMessages: {

      },
      child: ReactiveForm(
        formGroup: form,
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
