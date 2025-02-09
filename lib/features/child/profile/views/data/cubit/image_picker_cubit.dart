import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yosrixia/features/child/profile/views/data/cubit/image_picker_states.dart';

class ImagePickerCubit extends Cubit<ImagePickerStates> {
  ImagePickerCubit() : super(ImagePickerInitial());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(ImagePickerLoaded(File(pickedFile.path)));
    } else {
      emit( ImagePickerError());
    }
  }
}