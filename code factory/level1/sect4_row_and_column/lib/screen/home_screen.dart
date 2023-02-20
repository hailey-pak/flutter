import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //상태바나 홈버튼을 가리지 않게 하는 요소
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Colors.black,
          // width: MediaQuery.of(context).size.width, //화면의 너비를 가져옴
          // height: MediaQuery.of(context).size.height, //화면의 높이를 가져옴
          child: Column(
            // MainAxisAlignment - 주축 정렬
            // start - 시작
            // end - 끝
            // center - 가운데
            // spaceBetween - 위젯의 간격을 동일하게 배치
            // spaceEvenly - 위젯의 간격을 동일하게 배치하나 시작과 끝도 위젯이 아닌 빈 간격으로 시작한다.
            // spaceAround - spaceEvenly + 시작과 끝의 간격은 반으로 줄어듦.
            mainAxisAlignment: MainAxisAlignment.start,
            // CrossAxisAlignment - 반대축 정렬
            // start - 시작
            // end - 끝
            // center - 가운데 -- default
            // stretch - 빈 공간만큼 최대한으로 늘린다.
            crossAxisAlignment: CrossAxisAlignment.start,
            // MainAxisSize - 주축 크기
            // max - 최대
            // min - 최소
            mainAxisSize: MainAxisSize.max,
            children: [
              // Expanded / Flexible
              // Expanded - 화면 상의 남아 있는 영역을 최대로 차지함
              // Flexible - children 내부의 위젯들이 차지하는 영역을 비율별로 나눔
              Flexible(
                flex: 1,    //기본은 1 (나머지 공간을 차지하는 비율을 뜻함)
                child: Container(
                  color: Colors.red,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              Flexible(
                child: Container(
                  color: Colors.orange,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.yellow,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
