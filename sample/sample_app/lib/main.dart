import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample_app/const/colors.dart';
import 'package:sample_app/screen/spash_screen.dart';

void main() async {
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1600, 2560), // 디자인 사이즈

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
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: PRIMARY_COLOR,

          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
