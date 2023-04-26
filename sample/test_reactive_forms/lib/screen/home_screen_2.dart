import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';
import 'package:reactive_multi_image_picker/multi_image.dart';
import 'package:reactive_multi_image_picker/reactive_multi_image_picker.dart';
import 'package:test_reactive_forms/layout/default_layout.dart';
import 'package:test_reactive_forms/main.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  @override
  Widget build(BuildContext context) {
    final Box box = Hive.box(dataBox);
    final List<dynamic> keys = box.keys.toList();

    return DefaultLayout(
      title: 'Home Screen',
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: MediaForm(),
          ),
        ),
      ),
    );
  }
}

class MediaForm extends StatefulWidget {
  const MediaForm({Key? key}) : super(key: key);

  @override
  State<MediaForm> createState() => _MediaFormState();
}

class _MediaFormState extends State<MediaForm> {
  final form = fb.group({
    'image': FormControl<ImageFile>(),
    'multiImage': FormControl<MultiImage<String>>(),
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          ReactiveImagePicker(
            formControlName: 'image',
            decoration: const InputDecoration(
              labelText: '사진 추가',
            ),
          ),
          // ReactiveMultiImagePicker<String>(
          //   formControlName: 'multiImage',
          //   imagePickerBuilder: (pickImage, images, onChange) {
          //     return Column(
          //       children: [
          //         Expanded(
          //           child: GridView.count(
          //             crossAxisCount: 3,
          //             children: renderImageAsset(images.assets),
          //           ),
          //         ),
          //         ElevatedButton(
          //           onPressed: pickImage,
          //           child: const Text("Pick images"),
          //         ),
          //       ],
          //     );
          //   },
          // ),
          ReactiveFormConsumer(
            builder: (context, formGroup, child) {
              return ElevatedButton(
                  child: Text('저장'), onPressed: () => print(form.value));
            },
          ),
        ],
      ),
    );
  }

  List<AssetThumb> renderImageAsset(List<Asset> assets) {
    return List.generate(assets.length, (index) {
      Asset asset = assets[index];
      return AssetThumb(
        asset: asset,
        width: 150,
        height: 150,
      );
    });
  }
}
