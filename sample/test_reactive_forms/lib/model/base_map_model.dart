import 'package:hive/hive.dart';
import 'package:test_reactive_forms/model/column_def_model.dart';
import 'package:test_reactive_forms/model/field_model.dart';

import 'data_model.dart';

part 'base_map_model.g.dart';

@HiveType(typeId: 101)
class BaseMapModel implements IDataModel {
  @HiveField(0)
  final String ueepnu;
  @HiveField(1)
  final double gakuka;
  @HiveField(2)
  final int gimok;
  @HiveField(3)
  final int giyuk;
  @HiveField(4)
  final int? dist;
  @HiveField(5)
  final int? gita;
  @HiveField(6)
  final int yongdo;
  @HiveField(7)
  final double area;
  @HiveField(8)
  final String jibun;
  @HiveField(9)
  final double shape_leng;
  @HiveField(10)
  final double shape_area;

  BaseMapModel({
    required this.ueepnu,
    required this.gakuka,
    required this.gimok,
    required this.giyuk,
    this.dist,
    this.gita,
    required this.yongdo,
    required this.area,
    required this.jibun,
    required this.shape_leng,
    required this.shape_area,
  });

  BaseMapModel.fromJson(Map<String, dynamic> json)
      : ueepnu = json['UEEPNU'],
        gakuka = json['GAKUKA'],
        gimok = json['GIMOK'],
        giyuk = json['GIYUK'],
        dist = json['DIST'],
        gita = json['GITA'],
        yongdo = json['YONGDO'],
        area = json['AREA'],
        jibun = json['JIBUN'],
        shape_leng = json['SHAPE_LENG'],
        shape_area = json['SHAPE_AREA'];

  Map<String, dynamic> toJson() => {
        'UEEPNU': ueepnu,
        'GAKUKA': gakuka,
        'GIMOK': gimok,
        'GIYUK': giyuk,
        'DIST': dist,
        'GITA': gita,
        'YONGDO': yongdo,
        'AREA': area,
        'JIBUN': jibun,
        'SHAPE_LENG': shape_leng,
        'SHAPE_AREA': shape_area,
      };

  List<FieldModel> _controls = [];

  @override
  String getKey() {
    return ueepnu;
  }

  @override
  void initFields() {
    _controls.add(
      FieldModel(
        column: ColumnDefinitionModel(
          tableId: 'BASEMAP',
          columnName: 'UEEPNU',
          labelText: 'PNU',
          fieldType: 0,
          required: true,
          readOnly: true,
        ),
      ),
    );
    _controls.add(
      FieldModel(
        column: ColumnDefinitionModel(
            tableId: 'BASEMAP',
            columnName: 'GIMOK',
            labelText: '지목',
            fieldType: 2,
            required: true,
            readOnly: false,
            codeId: 'GIMOK'),
      ),
    );
    _controls.add(
      FieldModel(
        column: ColumnDefinitionModel(
          tableId: 'BASEMAP',
          columnName: 'YONGDO',
          labelText: '용도',
          fieldType: 1,
          required: true,
          readOnly: false,
        ),
      ),
    );
    _controls.add(
      FieldModel(
        column: ColumnDefinitionModel(
          tableId: 'BASEMAP',
          columnName: 'JIBUN',
          labelText: '지번',
          fieldType: 0,
          required: true,
          readOnly: false,
        ),
      ),
    );
  }

  @override
  List<FieldModel> getFields() {
    if (_controls.isEmpty) {
      initFields();
    }
    return _controls;
  }

  @override
  dynamic getValue(String colName) {
    return toJson()[colName];
  }
}
