import 'package:hive/hive.dart';
import 'package:test_reactive_forms/model/local_data_model.dart';

@HiveType(typeId: 11)
class BasicData extends LocalDataModel {
  final int num; //번호
  final String name; //사업장명
  final String address; //소재지전체
  final String? newAddress; //도로명전체
  final DateTime openDate; //개관일자
  final bool status; //영업상태명
  final DateTime? closeDate; //폐업일자
  final String type; //문화체육업
  final String code; //박물관미술
  final String manage; //설립_운영
  final String? closeReason; //폐관사유
  final String geoCode; //GEOCODE
  final double x; //GRS80_X
  final double y; //GRS80_Y

  BasicData({
    required this.num,
    required this.name,
    required this.address,
    this.newAddress,
    required this.openDate,
    required this.status,
    this.closeDate,
    required this.type,
    required this.code,
    required this.manage,
    this.closeReason,
    required this.geoCode,
    required this.x,
    required this.y,
  });

  @override
  void registerAdapter() {}

  BasicData.fromJson(Map<String, dynamic> json)
      : num = json['번호'],
        name = json['사업장명'],
        address = json['소재지전체'],
        newAddress = json['도로명전체'],
        openDate = json['개관일자'],
        status = json['영업상태명'],
        closeDate = json['폐업일자'],
        type = json['문화체육업'],
        code = json['박물관미술'],
        manage = json['설립_운영'],
        closeReason = json['폐관사유'],
        geoCode = json['GEOCODE'],
        x = json['GRS80_X'],
        y = json['GRS80_Y'];
}
