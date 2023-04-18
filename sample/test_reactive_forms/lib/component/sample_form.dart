import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

class SampleForm extends StatelessWidget {
  const SampleForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FormGroup form = FormGroup({
      'id': FormControl<String>(
        value: '데이터의 id값',
        validators: [Validators.required],
        disabled: true,
      ),
      'name': FormControl<String>(
        validators: [Validators.required, Validators.number],
      ),
      'date': FormControl<DateTime>(
        value: DateTime.now(), //이전 값이 존재 하지 않으면 현재 날짜
        validators: [Validators.required],
      ),
      'category': FormControl<int>(
        value: 2,
        validators: [Validators.required],
      ),
      'check': FormControl<bool>(),
      'time': FormControl<TimeOfDay>(),
      'switch': FormControl<bool>(),
      'radio': FormControl<String>(),
      'slider': FormControl<double>(),
      'image': FormControl<ImageFile>(),
    });

    return ReactiveFormConfig(
      validationMessages: {
        ValidationMessage.required: (error) => '필수로 입력해주세요.',
      },
      child: ReactiveForm(
        formGroup: form,
        child: Column(
          children: [
            ReactiveTextField(
              formControlName: 'id',
              decoration: InputDecoration(
                labelText: '관리번호',
              ),
            ),
            const SizedBox(height: 16.0),
            ReactiveTextField(
              formControlName: 'name',
              decoration: InputDecoration(
                labelText: '이름',
              ),
            ),
            const SizedBox(height: 16.0),
            ReactiveTextField<DateTime>(
              formControlName: 'date',
              decoration: InputDecoration(
                labelText: '관리 일자',
                suffixIcon: ReactiveDatePicker<DateTime>(
                  formControlName: 'date',
                  firstDate: DateTime(1985),
                  lastDate: DateTime.now(),
                  builder: (context, picker, child) {
                    return IconButton(
                      onPressed: picker.showPicker,
                      icon: const Icon(Icons.date_range),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ReactiveTextField<TimeOfDay>(
              formControlName: 'time',
              decoration: InputDecoration(
                labelText: '시간',
                suffixIcon: ReactiveTimePicker(
                  formControlName: 'time',
                  builder: (context, picker, child) {
                    return IconButton(
                      onPressed: picker.showPicker,
                      icon: const Icon(Icons.access_time),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ReactiveDropdownField<int>(
              formControlName: 'category',
              decoration: const InputDecoration(
                labelText: '카테고리',
              ),
              items: const [
                DropdownMenuItem(
                  value: 0,
                  child: Text('aaa'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('bbb'),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text('ccc'),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text('ddd'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ReactiveSwitchListTile(
              formControlName: 'switch',
              title: Text('swtich'),
            ),
            const SizedBox(height: 16.0),
            ReactiveCheckboxListTile(
              formControlName: 'check',
              title: Text('check box'),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ReactiveRadioListTile<String>(
                    title: Text('radio1'),
                    value: 'radio1',
                    formControlName: 'radio',
                  ),
                ),
                Expanded(
                  child: ReactiveRadioListTile<String>(
                    title: Text('radio2'),
                    value: 'radio2',
                    formControlName: 'radio',
                  ),
                ),
                Expanded(
                  child: ReactiveRadioListTile<String>(
                    title: Text('radio3'),
                    value: 'radio3',
                    formControlName: 'radio',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ReactiveSlider(
              formControlName: 'slider',
              max: 100,
              divisions: 100,
              labelBuilder: (p0) => '${p0.toStringAsFixed(1)}%',
            ),
            const SizedBox(height: 16.0),
            ReactiveImagePicker(
              formControlName: 'image',
              decoration: InputDecoration(
                labelText: '이미지 삽입',
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
