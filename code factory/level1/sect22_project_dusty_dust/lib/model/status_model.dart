import 'package:flutter/material.dart';

class StatusModel {
  final int level; // 단계
  final String label; // 단계 이름
  final Color primaryColor; // 주 색상
  final Color darkColor; // 어두운 색상
  final Color lightColor; // 밝은 색상
  final Color detailFontColor; // 폰트 색상
  final String imagePath; // 이모티콘 이미지
  final String comment; // 코멘트
  final double minFineDust; // 미세먼지 최소치
  final double minUltraFineDust; // 초미세먼지 최소치
  final double minO3; // 오존 최소치
  final double minNO2; // 이산화질소 최소치
  final double minCO; // 일산화탄소 최소치
  final double minSO2; // 이황산가스 최소치

  StatusModel({
    required this.level,
    required this.label,
    required this.primaryColor,
    required this.darkColor,
    required this.lightColor,
    required this.detailFontColor,
    required this.imagePath,
    required this.comment,
    required this.minFineDust,
    required this.minUltraFineDust,
    required this.minO3,
    required this.minNO2,
    required this.minCO,
    required this.minSO2,
  });
}
