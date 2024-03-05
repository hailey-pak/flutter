import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Sign up',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 56.h,
        backgroundColor: Colors.white,
        leading: Icon(Icons.chevron_left),
      ),
      body: Column(
        children: [
          _frame1(),
          Expanded(child: Container()),
          _frame2(),
        ],
      ),
    );
  }

  Widget _frame1() {
    return Padding(
      padding: EdgeInsets.all(16.w),
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
              )
            : null,
      ),
    );
  }

  Widget _frame2() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
            onPressed: null,
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
