import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_reactive_forms/model/code_model.dart';
import 'package:test_reactive_forms/model/emd_model.dart';
import 'package:test_reactive_forms/screen/home_screen.dart';

const emdBox = 'emd';
const codeBox = 'code';

void main() async {
  await Hive.initFlutter();                   // Hive 사용을 위해 초기화
  Hive.registerAdapter(EmdModelAdapter());    // Adapter 등록

  await Hive.openBox<EmdModel>(emdBox);                 // 박스를 열어서 로컬메모리에 저장된 데이터를 읽어옴

  var box = await Hive.openBox(codeBox);
  // 코드 값 저장
  if (box.isEmpty || box.length == 0) {
    String jsonString = await rootBundle.loadString('assets/CODE.json');
    List<dynamic> codeJson = jsonDecode(jsonString);

    List<CodeModel> codeList = [];
    for (var json in codeJson) {
      CodeModel codeModel = CodeModel.fromJson(json); //json읽어서 코드모델 생성

      //기존에 있는 id면 저장되어있는 리스트 업데이트
      if (box.containsKey(codeModel.codeId)) {
        codeList = box.get(codeModel.codeId);
      } else {
        codeList.clear();
      }
      codeList.add(codeModel);
      box.put(codeModel.codeId, codeList);
    }
    print('code 초기화');
  }



  runApp(
     const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      //  home: DefaultLayout(
      //    title: 'sample form',
      //    body: SampleForm(),
      //  ),
    ),
  );
}
