import 'package:test_reactive_forms/model/field_model.dart';

abstract class IFormModel {
  void initFields();
  List<FieldModel> getFields();
}