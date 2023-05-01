import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';
import 'package:test_reactive_forms/layout/default_layout.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  List<String> imagePaths = [];

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  getPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.microphone,
      Permission.videos,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'image test',
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imagePaths.length + 1,
                itemBuilder: (context, index) {
                  if (index == imagePaths.length) {
                    return addImageView(context);
                  }
                  return renderImage(imageFile: File(imagePaths[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderImage({
    required File imageFile,
  }) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(imageFile),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget addImageView(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: OutlinedButton(
        onPressed: () => imageAddClickEvent(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<Image> xFileToImage(XFile xFile) async {
    final bytes = await xFile.readAsBytes();
    return Image.memory(bytes);
  }

  void imageAddClickEvent(BuildContext context) {
    //카메라 or 갤러리 선택 버튼 하단 창으로 띄우기
    showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 200,
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white, // 모달 배경색
            borderRadius: BorderRadius.all(
              Radius.circular(20), // 모달 전체 라운딩 처리
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => getImage(
                  imageSource: ImageSource.camera,
                ),
                child: Text('카메라로 촬영하기'),
              ),
              ElevatedButton(
                onPressed: () => getImage(
                  imageSource: ImageSource.gallery,
                ),
                child: Text('앨범에서 가져오기'),
              ),
            ],
          ),
        );
      },
    );
  }

  void getImage({
    required ImageSource imageSource,
  }) async {
    final ImagePicker picker = ImagePicker();

    // 카메라로 촬영
    if (imageSource == ImageSource.camera) {
      XFile? file = await picker.pickImage(source: imageSource);

      if (file != null) {
        setState(() {
          imagePaths.add(file.path);
        });
      }
    } else {
      // 갤러리에서 선택
      List<XFile> images = await picker.pickMultiImage();

      if (images.isNotEmpty) {
        List<String> resultList = images.map((e) => e.path).toList();

        setState(() {
          imagePaths.addAll(resultList);
        });
      }
    }
  }
}
