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
      designSize: const Size(360, 690),
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
      appBar: AppBar(
        title: Text(
          'Screen Util Test',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //for example:
            //If you want to display a rectangle:
            Container(
              color: Colors.red,
              width: 100.w,
              height: 100.h,
            ),
            Padding(
              padding: const EdgeInsets.all(100).w,
              child: Container(
                color: Colors.orange,
                width: 100.w,
                height: 100.w,
              ),
            ),
            //If you want to display a square based on height:
            Container(
              color: Colors.yellow,
              width: 100.h,
              height: 100.h,
            ),

            //If you want to display a square based on minimum(height, width):
            Container(
              color: Colors.green,
              width: 100.r,
              height: 100.r,
            ),
          ],
        ),
      ),
    );
  }
}
