import 'package:hive/hive.dart';

abstract class LocalDataModel extends HiveObject {


  //어댑터 등록
  void registerAdapter();

  //박스 오픈
  Box openBox(String boxName) {
    if (!Hive.isBoxOpen(boxName)) {
      Hive.openBox(boxName);
    }
    return Hive.box(boxName);
  }


}
