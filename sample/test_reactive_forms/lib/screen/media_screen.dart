import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';
import 'package:test_reactive_forms/component/custom_sound_recorder.dart';
import 'package:test_reactive_forms/component/custom_video_player.dart';
import 'package:test_reactive_forms/layout/default_layout.dart';
import 'package:video_player/video_player.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  List<String> imagePaths = [];
  String? videoPath;

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Center(child: Text('이미지 추가')),
              // 이미지 추가
              SizedBox(
                height: 300,
                width:
                    imagePaths.isEmpty ? 300 : MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imagePaths.length + 1,
                  itemBuilder: (context, index) {
                    // 마지막 인덱스에 이미지 추가 박스 띄우기
                    if (index == imagePaths.length) {
                      return addImageView(
                        onPressed: () => _pickImage(context),
                      );
                    }

                    return renderImage(
                      imageFile: File(imagePaths[index]),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              const Center(child: Text('동영상 추가')),
              // 동영상 추가
              SizedBox(
                height: 300,
                child: videoPath == null
                    ? addImageView(
                        onPressed: () => _pickVideo(context),
                      )
                    : renderVideo(videoPath: videoPath!),
              ),
              const SizedBox(height: 30),
              const Center(child: Text('녹음 추가')),
              CustomSoundRecorder(),
            ],
          ),
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
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }

  Widget renderVideo({
    required String videoPath,
  }) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: CustomVideoPlayer(
        videoPath: videoPath,
      ),
    );
  }

  Widget addImageView({
    required VoidCallback onPressed,
  }) {
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
        onPressed: onPressed,
        child: const Icon(Icons.add),
      ),
    );
  }

  // 이미지소스 선택하는 다이얼로그 (카메라 or 앨범)
  Future<ImageSource?> _imageSourceDialog({
    required BuildContext context,
    bool isCamera = true,
  }) async {
    return await showModalBottomSheet<ImageSource>(
      isScrollControlled: true,
      context: context,
      builder: (context) => Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ListTile(
                      leading: isCamera
                          ? const Icon(Icons.photo_camera)
                          : const Icon(Icons.video_call),
                      title: const Text('직접 촬영하기'),
                      onTap: () =>
                          Navigator.of(context).pop(ImageSource.camera),
                    ),
                    ListTile(
                      leading: isCamera
                          ? const Icon(Icons.photo)
                          : const Icon(Icons.video_collection),
                      title: const Text('앨범에서 선택하기'),
                      onTap: () =>
                          Navigator.of(context).pop(ImageSource.gallery),
                    ),
                    ListTile(
                      leading: const Icon(Icons.clear),
                      title: const Text('취소'),
                      onTap: Navigator.of(context).pop,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  //이미지 선택하기
  void _pickImage(BuildContext context) async {
    final source = await _imageSourceDialog(context: context);

    if (source != null) {
      final ImagePicker picker = ImagePicker();

      // 카메라로 촬영
      if (source == ImageSource.camera) {
        XFile? file = await picker.pickImage(source: source);

        if (file != null) {
          setState(() {
            imagePaths.add(file.path);
          });
        }
      } else {
        // 갤러리에서 선택 (다중선택 가능)
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

  // 비디오 선택하기
  void _pickVideo(BuildContext context) async {
    final source = await _imageSourceDialog(
      context: context,
      isCamera: false,
    );

    if (source != null) {
      final ImagePicker picker = ImagePicker();
      XFile? file = await picker.pickVideo(source: source);

      if (file != null) {
        setState(() {
          videoPath = file.path;
        });
      }
    }
  }
}
