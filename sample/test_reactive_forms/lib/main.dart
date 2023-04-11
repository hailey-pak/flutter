import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_reactive_forms/model/emd_model.dart';
import 'package:test_reactive_forms/screen/home_screen.dart';

const emdBox = 'emd';

void main() async {
  await Hive.initFlutter();                   // Hive 사용을 위해 초기화
  Hive.registerAdapter(EmdModelAdapter());    // Adapter 등록

  await Hive.openBox<EmdModel>(emdBox);                 // 박스를 열어서 로컬메모리에 저장된 데이터를 읽어옴

  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
