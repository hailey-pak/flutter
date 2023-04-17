import 'package:hive/hive.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/models/models.dart';
import 'package:test_reactive_forms/model/field_model.dart';

import 'data_model.dart';


class BaseMapModel implements IDataModel {
  final String ueepnu;
  final double gakuka;
  final int gimok;
  final int giyuk;
  final int dist;
  final int gita;
  final int yongdo;
  final double area;
  final String jibun;
  final double shape_leng;
  final double shape_area;

  BaseMapModel({
    required this.ueepnu,
    required this.gakuka,
    required this.gimok,
    required this.giyuk,
    required this.dist,
    required this.gita,
    required this.yongdo,
    required this.area,
    required this.jibun,
    required this.shape_leng,
    required this.shape_area,
});


  @override
  List<FieldModel> _fields = [];

  @override
  String getKey() {
    return ueepnu;
  }

  // @override
  // void initField(List<FieldModel> fields) {
  //   Map<String, Object> controls = {};
  //   for (FieldModel field in fields) {
  //     controls[field.columnName] = ['', ];
  //   }
  // }


  @override
  void initControls() {
    // TODO: implement initControls
  }


  @override
  FormGroup getFormGroup() {
    throw UnimplementedError();
  }



}