import 'package:flutter/material.dart';

void main() async {
  //스크린 유틸 안 쓰고 만들 경우 테스트

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'Sign up',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 56,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.chevron_left, size: 24),
        leadingWidth: 56,
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getTextField('First name'),
          const SizedBox(height: 8),
          _getTextField('Last name'),
          const SizedBox(height: 8),
          const Text(
            'Make sure it matches the name on your government ID.',
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          _getTextField('Email'),
          const SizedBox(height: 8),
          const Text(
            'We will email you trip confirmations and receipts.',
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          _getTextField('Password', icon: Icons.visibility),
        ],
      ),
    );
  }

  Widget _getTextField(String title, {IconData? icon}) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        hintText: title,
        hintStyle: const TextStyle(fontSize: 16, color: Color(0xFF64748B)),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: const TextSpan(
                style: TextStyle(fontSize: 14, color: Color(0xFF020617)),
                text: 'By selecting Agree and continue, I agree to Dynamic Layers ',
                children: <TextSpan>[
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
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              backgroundColor: const Color(0xFF7E49FF),
              disabledBackgroundColor: const Color(0xFFF1F5F9),
              minimumSize: const Size(double.maxFinite, double.minPositive),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
            child: const Text(
              'Agree and continue',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFCBD5E1)),
            ),
          ),
        ],
      ),
    );
  }
}
