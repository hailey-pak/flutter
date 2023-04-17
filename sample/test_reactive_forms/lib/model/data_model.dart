import 'package:reactive_forms/reactive_forms.dart';
import 'package:test_reactive_forms/model/control_model.dart';
import 'package:test_reactive_forms/model/field_model.dart';

abstract class IDataModel {
  List<ControlModel> _controls = [];

  String getKey();
  // void initField(List<FieldModel> fields);
  void initControls();
  FormGroup getFormGroup();


}