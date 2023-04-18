import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'code_model.g.dart';

@HiveType(typeId: 0)
class CodeModel {
  @HiveField(0)
  final String codeId; //코드 분류 아이디
  @HiveField(1)
  final dynamic code; //코드값
  @HiveField(2)
  final String name; //코드명 (화면에 보여질 이름)

  CodeModel({
    required this.codeId,
    required this.code,
    required this.name,
  });

  CodeModel.fromJson(Map<String, dynamic> json)
      : codeId = json['ID'],
        code = json['CODE'],
        name = json['NAME'];
}
