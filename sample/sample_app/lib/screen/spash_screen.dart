import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample_app/screen/login_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _permission = false;

  Future<void> checkPermission() async {
    Future<bool> permission = getPermission();
    permission.then((status) {
      if (!status) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('권한 설정을 확인해주세요.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    openAppSettings(); //앱 설정으로 이동
                  },
                  child: Text('설정으로 이동'),
                )
              ],
            );
          },
        );
      }
    }, onError: (error) {
      print(error);
      SystemNavigator.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/sample_logo.gif'),
      function: () => checkPermission(),
      nextScreen: LoginScreen(),
      // nextScreen: _permission ? RootLayout() : NullScreen(),
      backgroundColor: Colors.white,
      animationDuration: Duration(seconds: 3),
      pageTransitionType: PageTransitionType.bottomToTop,

    );
  }

  Future<bool> getPermission() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.location, //위치
      Permission.camera, //카메라
      Permission.storage, //저장소
      Permission.microphone, //마이크
      // Permission.notification //알림
    ].request();


    if (status.values.contains(PermissionStatus.denied) ||
        status.values.contains(PermissionStatus.permanentlyDenied)) {
      return false;
    }
    return true;
  }
}

class NullScreen extends StatelessWidget {
  const NullScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('권한이 허용되지 않아 앱을 종료합니다.'),
          ),
        ),
      ),
    );
  }
}
