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
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  bool isTablet = false;

  @override
  Widget build(BuildContext context) {
    if (ScreenUtil().deviceType() == DeviceType.tablet) {
      ScreenUtil.configure(designSize: const Size(834, 1294));
      isTablet = true;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Sign up',
          style: TextStyle(
            fontSize: isTablet? 32.sp : 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        toolbarHeight: isTablet? 64.h : 56.h,
        backgroundColor: Colors.white,
        leading: Icon(Icons.chevron_left, size: isTablet? 48.w : 24.w),
        leadingWidth: isTablet? 64.h : 56.h,
      ),
      body: Column(
        children: [
          isTablet? 0.15.sh.verticalSpace : 16.verticalSpace,
          _frame1(),
          Expanded(child: Container()),
          _frame2(),
          isTablet? 0.2.sh.verticalSpace : 16.verticalSpace,
        ],
      ),
    );
  }

  Widget _frame1() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet? 220.w : 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getTextField('First name'),
          8.verticalSpace,
          _getTextField('Last name'),
          8.verticalSpace,
          Text(
            'Make sure it matches the name on your government ID.',
            style: TextStyle(
              color: const Color(0xFF64748B),
              fontSize: 14.sp,
            ),
          ),
          16.verticalSpace,
          _getTextField('Email'),
          8.verticalSpace,
          Text(
            'We will email you trip confirmations and receipts.',
            style: TextStyle(
              color: const Color(0xFF64748B),
              fontSize: 14.sp,
            ),
          ),
          16.verticalSpace,
          _getTextField('Password', icon: Icons.visibility),
        ],
      ),
    );
  }

  Widget _getTextField(String title, {IconData? icon}) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)).w,
        ),
        hintText: title,
        hintStyle: TextStyle(fontSize: 16.sp, color: const Color(0xFF64748B)),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        suffixIcon: icon != null
            ? Icon(
                icon,
                color: const Color(0xFF64748B),
                size: 24.w
              )
            : null,
        suffixIconConstraints: BoxConstraints(
          minWidth: 48.w,
        ),
      ),
    );
  }

  Widget _frame2() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet? 220.w : 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
                style: TextStyle(fontSize: 14.sp, color: const Color(0xFF020617)),
                text: 'By selecting Agree and continue, I agree to Dynamic Layers ',
                children: const <TextSpan>[
                  TextSpan(
                    text: 'Terms of Service, Payments Terms of Service',
                    style: TextStyle(
                      color: Color(0xFF7E49FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Notification Policy',
                    style: TextStyle(
                      color: Color(0xFF7E49FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: ' and acknowledge the '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: Color(0xFF7E49FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: '.'),
                ]),
          ),
          16.verticalSpace,
          ElevatedButton(
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
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              backgroundColor: const Color(0xFF7E49FF),
              disabledBackgroundColor: const Color(0xFFF1F5F9),
              minimumSize: const Size(double.maxFinite, double.minPositive),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.w))),
            ),
            child: Text(
              'Agree and continue',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFFCBD5E1)),
            ),
          ),
        ],
      ),
    );
  }
}
