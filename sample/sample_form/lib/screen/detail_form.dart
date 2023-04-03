import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sample_form/layout/default_layout.dart';

class DetailForm extends StatelessWidget {
  const DetailForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

    return DefaultLayout(
      title: 'Detail Form',
      body: SafeArea(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: FormBuilderTextField(
              name: 'text',
              onChanged: (val) {
                print(val);
              },
            ),
          ),
        ),
      ),
    );
  }
}
