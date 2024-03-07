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
      designSize: const Size(370, 780),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
          theme: ThemeData(fontFamily: 'Lato', scaffoldBackgroundColor: const Color(0xFFD8D8D8)),
          themeMode: ThemeMode.system,
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
        title: const Text('Category'),
        titleTextStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: -0.2.sp, fontFamily: 'Lato'),
        toolbarHeight: 48.h,
        backgroundColor: const Color(0xFFF92841),
        leading: _getAppbarIcon(Icons.chevron_left),
        actions: [
          _getAppbarIcon(Icons.search),
          25.horizontalSpace,
          _getAppbarIcon(Icons.shopping_cart),
          15.horizontalSpace,
        ],
      ),
      body: _content(),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  Widget _getAppbarIcon(IconData icon) {
    return Icon(
      icon,
      size: 24.r,
      color: Colors.white,
    );
  }

  Widget _bottomNavigation() {
    return Container(
      color: const Color(0xFFF92841),
      height: 56.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _getBottomMenu(Icons.home_filled, 'Home', Colors.white),
          _getBottomMenu(Icons.widgets, 'Category', Colors.black),
          _getBottomMenu(Icons.discount, 'Offers', Colors.white),
          _getBottomMenu(Icons.account_circle_rounded, 'Account', Colors.white),
        ],
      ),
    );
  }

  Widget _getBottomMenu(IconData icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 24.r,
          color: color,
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 12.sp,
            fontWeight: label == 'Category' ? FontWeight.w900 : FontWeight.w500,
            letterSpacing: -0.2.sp,
            color: color,
          ),
        )
      ],
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      child: Column(
        children: [
          15.verticalSpace,
          _getCard(title: 'Cardio \nExercise \nEquipments', fileName: 'cardio.png'),
          _getCard(title: 'Fitness \nExercise \nEquipments', fileName: 'fitness.png'),
          _getCard(title: 'Proteins & \nSupplements', fileName: 'proteins.png'),
          _getCard(title: 'Gym \nAccessories', fileName: 'gym.png'),
        ],
      ),
    );
  }

  Widget _getCard({required String fileName, required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      child: Container(
        width: 340.w,
        height: 144.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            10.horizontalSpace,
            SizedBox(
              width: 173.w,
              height: 122.h,
              child: Image.asset('assets/images/$fileName'),
            ),
            10.horizontalSpace,
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.2.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
