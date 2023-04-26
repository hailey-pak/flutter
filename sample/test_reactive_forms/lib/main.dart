import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_reactive_forms/model/code_model.dart';
import 'package:test_reactive_forms/model/column_def_model.dart';
import 'package:test_reactive_forms/model_old/emd_model.dart';
import 'package:test_reactive_forms/screen/home_screen.dart';
import 'package:test_reactive_forms/test/base_map_model.dart';

const emdBox = 'emd';
const codeBox = 'code';
const dataBox = 'data';

void main() async {
  await Hive.initFlutter();                   // Hive 사용을 위해 초기화
  Hive.registerAdapter(CodeModelAdapter());    // Adapter 등록
  Hive.registerAdapter(ColumnDefinitionModelAdapter());    // Adapter 등록
  Hive.registerAdapter(EmdModelAdapter());    // Adapter 등록
  Hive.registerAdapter(BaseMapModelAdapter());    // Adapter 등록

  var box = await Hive.openBox(codeBox);
  // 코드 값 저장
  if (box.isEmpty || box.length == 0) {
    String jsonString = await rootBundle.loadString('assets/code_table.json');
    List<dynamic> codeJson = jsonDecode(jsonString);

    List<CodeModel> codeList = [];
    for (var json in codeJson) {
      CodeModel codeModel = CodeModel.fromJson(json); //json읽어서 코드모델 생성

      //기존에 있는 id면 저장되어있는 리스트 업데이트
      if (box.containsKey(codeModel.codeId)) {
        codeList = box.get(codeModel.codeId)!;
      } else {
        codeList.clear();
      }
      codeList.add(codeModel);
      box.put(codeModel.codeId, codeList);
    }
    print('code 초기화');

  }
  print("${box.name}: ${box.length}");

  var box2 = await Hive.openBox<EmdModel>(emdBox);                 // 박스를 열어서 로컬메모리에 저장된 데이터를 읽어옴

  // 초기 데이터가 없으면 박스에 데이터 생성하기
  if (box2.isEmpty || box2.length == 0) {
    String jsonString = await rootBundle.loadString('assets/JEJU_UMD.json');
    List<dynamic> mapList = jsonDecode(jsonString);

    for (var map in mapList) {
      EmdModel model = EmdModel.fromJson(map);
      box2.put(model.input_fid, model);
    }
    print('emd box 초기화');
  }
  print('${box2.name}: ${box2.length}');

  var box3 = await Hive.openBox(dataBox);
  if (box3.isEmpty || box3.length == 0) {
    String jsonString = await rootBundle.loadString('assets/base_map.json');
    List<dynamic> mapList = jsonDecode(jsonString);

    for (var map in mapList) {
      BaseMapModel model = BaseMapModel.fromJson(map);
      box3.put(model.ueepnu, model);
    }
    print('baseMapBox 초기화');
  }
  print('${box3.name}: ${box3.length}');


  runApp(
     const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}

