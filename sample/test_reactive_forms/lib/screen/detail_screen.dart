import 'package:flutter/material.dart';
import 'package:test_reactive_forms/component/data_form.dart';
import 'package:test_reactive_forms/layout/default_layout.dart';
import 'package:test_reactive_forms/model/field_model.dart';

class DetailScreen extends StatefulWidget {
  final String fid;

  const DetailScreen({
    required this.fid,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final List<FieldModel> fields = [];

  @override
  void initState() {
    super.initState();

    initFields();
  }

  // 필드 초기화
  void initFields() {
    fields.addAll({
      FieldModel(
        columnName: 'INPUT_FID',
        labelText: 'ID',
        controlType: ControlType.TextField,
        valueType: String,
        readOnly: true,
      ),
      FieldModel(
        columnName: 'EMD_CD',
        labelText: '읍면동코드',
        controlType: ControlType.TextField,
        valueType: String,
        readOnly: true,
      ),
      FieldModel(
        columnName: 'EMD_NM',
        labelText: '음면동명',
        controlType: ControlType.TextField,
        valueType: String,
        readOnly: false,
      ),
      FieldModel(
        columnName: 'SGG_OID',
        labelText: '시군구일련번호',
        controlType: ControlType.TextField,
        valueType: int,
        readOnly: false,
      ),
      FieldModel(
          columnName: 'COL_ADM_SE',
          labelText: '시군구코드',
          controlType: ControlType.DropDown,
          valueType: String,
          readOnly: false,
          items: [
            const DropdownMenuItem(
              value: '50110',
              child: Text('제주시'),
            ),
            const DropdownMenuItem(
              value: '50130',
              child: Text('서귀포시'),
            ),
          ]
      ),
      FieldModel(
        columnName: 'GID',
        labelText: '공간정보일련번호',
        controlType: ControlType.TextField,
        valueType: int,
        readOnly: true,
      ),

    });
  }


  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Detail Screen',
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: DataForm(
                fields: fields,
                fid: widget.fid),
          ),
        ),
      ),
    );
  }
}
