import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(
      title: 'Route Two',
      children: [
        Text(
          'arguments: ${arguments}',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Pop',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              '/three',
              arguments: 999,
            );
          },
          child: Text('Push Named'),
        ),
        ElevatedButton(
          onPressed: () {
            // 원래 순서 [HomeScreen(), RouteOne(), RouteTwo()]
            // 실행 후 순서 [HomeScreen(), RouteOne(), RouteThree()]
            // pushReplacement --> 호출한 route를 대신해 준다. three가 two를 대신
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => RouteThreeScreen(),
              ),
            );
            // Navigator.of(context).pushReplacementNamed(
            //   '/three',
            // );
          },
          child: Text('Push Replacement'),
        ),
        ElevatedButton(
          onPressed: () {
            // 원래 순서 [HomeScreen(), RouteOne(), RouteTwo()]
            // 실행 후 순서 [HomeScreen(), RouteThree()]
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/three',
              (route) => route.settings.name == '/',  //입력한 이름의 라우터에 다다를 때까지의 라우터를 삭제함
            );
          },
          child: Text('Push And Reomove Until'),
        ),
      ],
    );
  }
}
