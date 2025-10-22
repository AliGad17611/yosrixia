import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Picker {
  static Future<File> pickImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(pickedFile?.path ?? '');
  }
}