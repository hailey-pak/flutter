import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample_app/layout/root_layout.dart';

void main() {
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // double width = 180.w // 숫자 뒤에 *.w를 쓰면, designSize 기준 가로 길이가 된다.
      // double height = 300.h // 숫자 뒤에 *.h를 쓰면, designSize 기준 세로 길이가 된다.
      // double textSize = 18.sp // 숫자 뒤에 *.sp를 쓰면, designSize 기준 폰트 크기가 설정된다.
      designSize: const Size(1600, 2560),   // 디자인 사이즈

      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return MediaQuery(
              // 기기의 폰트 사이즈를 따라 가지 않고 고정할 경우 설정
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          home: RootLayout(),
        );
      },
    );
  }
}
