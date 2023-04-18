import 'package:test_reactive_forms/model/field_model.dart';

abstract class IDataModel {
  List<FieldModel> _controls = [];

  String getKey();
  void initFields();
  List<FieldModel> getFields();
  dynamic getValue(String colName);
}