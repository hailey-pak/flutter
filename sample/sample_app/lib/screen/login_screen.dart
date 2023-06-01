import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sample_app/const/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    controller.forward(); //애니메이션 실행
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.4;
    Animation<RelativeRect> _rect = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, 0, 0, 0),
      end:  RelativeRect.fromLTRB(0, -height, 0, 0),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); //키보드 닫기
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(32.w),
            child: Stack(
              children: [
                PositionedTransition(
                  rect: _rect,
                  child: _Logo(),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.5,
                  child: _Form(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _Logo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Center(
        child: Image.asset(
          'assets/images/Logo.png',
          // width: 1000.w,
          width: MediaQuery.of(context).size.width * 0.7,
        ),
      ),
    );
  }

  Widget _Form() {
    final form = fb.group({
      'email': ['', Validators.required, Validators.email],
      'password': ['', Validators.required],
    });

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: ReactiveForm(
          formGroup: form,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                ReactiveTextField<String>(
                  formControlName: 'email',
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: '이메일',
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) => '이메일을 입력해주세요.',
                    ValidationMessage.email: (_) => '올바른 이메일 형식이 아닙니다.'
                  },
                ),
                SizedBox(height: 32.w),
                ReactiveTextField<String>(
                  formControlName: 'password',
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) => '비밀번호를 입력해주세요.',
                  },
                ),
                SizedBox(height: 64.w),
                ElevatedButton(
                  onPressed: () {
                    if (form.valid) {
                      print(form.value);
                    } else {
                      form.markAllAsTouched();
                      print(form.value);
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(400.w),
                    padding: EdgeInsets.symmetric(vertical: 16.w),
                    backgroundColor: SUB_COLOR,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 48.sp,
                    ),
                  ),
                  child: const Text('로그인'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
