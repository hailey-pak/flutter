import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';
import 'package:reactive_multi_image_picker/reactive_multi_image_picker.dart';
import 'package:test_reactive_forms/screen/home_screen_2.dart';

void main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Image> imageList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            //새로이 추가된 부분!!! 사진을 화면에 그려주기 위한 부분이다.
            imageList.isEmpty
                ? Container()
                : SizedBox(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return imageList[index];
                      },
                    ),
                  ),
            OutlinedButton(
              child: Container(
                alignment: Alignment.center,
                height: 30,
                width: 250,
                child: Text(
                  '갤러리',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              onPressed: () {
                getImage();
              },
            )
          ],
        ),
      ),
    );
  }

  getImage() async {
    List<Image> resultList = [];

    List<XFile> images = await ImagePicker().pickMultiImage();

    resultList = images
        .map(
          (xFile) => Image.file(
            File(xFile.path),
            width: 300,
            height: 300,
          ),
        )
        .toList();
    setState(() {
      imageList = resultList;
    });
  }

  Future<Image> xFileToImage(XFile xFile) async {
    final bytes = await xFile.readAsBytes();
    return Image.memory(bytes);
  }
}
