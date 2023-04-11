import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_reactive_forms/layout/default_layout.dart';
import 'package:test_reactive_forms/main.dart';
import 'package:test_reactive_forms/model/emd_model.dart';
import 'package:test_reactive_forms/model/field_model.dart';
import 'package:test_reactive_forms/screen/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Box<EmdModel> box = Hive.box(emdBox);

  @override
  void initState() {
    super.initState();

    initData();
  }

  Future<void> initData() async {
    // 초기 데이터가 없으면 박스에 데이터 생성하기
    if (box.isEmpty || box.length == 0) {
      String jsonString = await rootBundle.loadString('assets/JEJU_UMD.json');
      List<dynamic> mapList = jsonDecode(jsonString);

      for (var map in mapList) {
        EmdModel model = EmdModel.fromJson(map);
        box.put(model.input_fid, model);
      }
      print('emd box 초기화');
    }
    print('emd box 데이터: ${box.length}개');
  }

  @override
  Widget build(BuildContext context) {
    final valueList = box.values.toList();

    List<FieldModel> emdFields = [];
    emdFields.addAll({
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

    return DefaultLayout(
      title: 'Home Screen',
      body: GridView.count(
        crossAxisCount: 5,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        children: valueList
            .map(
              (emd) => ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          DetailScreen(fields: emdFields, fid: emd.input_fid),
                    ),
                  );
                },
                child: Text(emd.input_fid),
              ),
            )
            .toList(),
      ),
    );
  }
}
