import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_reactive_forms/model/emd_model.dart';
import 'package:test_reactive_forms/screen/home_screen.dart';

const emdBox = 'emd';

void main() async {
  await Hive.initFlutter();                   // Hive 사용을 위해 초기화
  Hive.registerAdapter(EmdModelAdapter());    // Adapter 등록

  await Hive.openBox(emdBox);                 // 박스를 열어서 로컬메모리에 저장된 데이터를 읽어옴

  // 초기 데이터가 없으면 박스에 데이터 생성하기
  final box = Hive.box(emdBox);

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

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
