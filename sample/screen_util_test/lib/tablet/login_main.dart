import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1600, 2560),
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _title(),
            310.h.verticalSpace,
            _block(),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      'Title',
      style: TextStyle(
        fontSize: 200.sp,
        height: 1.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _block() {
    return SizedBox(
      width: 1120.w,
      height: 745.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back !!!',
            style: TextStyle(
              fontSize: 64.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFD885A3),
            ),
          ),
          Text(
            'Log In',
            style: TextStyle(
              fontSize: 64.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 32.sp,
                ),
              ),
              SizedBox(
                height: 96.h,
                child: const TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFC0DBEA),
                    border: InputBorder.none,
                  ),
                  expands: true,
                  maxLines: null,
                  maxLength: null,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 32.sp,
                ),
              ),
              SizedBox(
                height: 96.h,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFC0DBEA),
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: const Color(0xFFD885A3),
                      size: 64.w,
                    ),
                    suffixIconConstraints: BoxConstraints(minWidth: 128.w),
                  ),
                  expands: true,
                  maxLines: null,
                  maxLength: null,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  print('Device Size:${Size(1.sw, 1.sh)}');
                  print('Device pixel density:${ScreenUtil().pixelRatio}');
                  print('Bottom safe zone distance dp:${ScreenUtil().bottomBarHeight}dp');
                  print('Status bar height dp:${ScreenUtil().statusBarHeight}dp');
                  print('The ratio of actual width to UI design:${ScreenUtil().scaleWidth}');
                  print(
                      'The ratio of actual height to UI design:${ScreenUtil().scaleHeight}');
                  print('System font scaling:${ScreenUtil().textScaleFactor}');
                  print('0.5 times the screen width:${0.5.sw}dp');
                  print('0.5 times the screen height:${0.5.sh}dp');
                  print('Screen orientation:${ScreenUtil().orientation}');
                  print(ScreenUtil().deviceType());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD885A3),
                  fixedSize: Size(360.w, 100.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.w)),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'LOG IN',
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.login,
                      size: 50.w,
                      color: Colors.white,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

}
