import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yosrixia/features/child/profile/data/image_cubit/image_picker_states.dart';
import 'package:yosrixia/features/child/profile/data/firestore_service.dart';
import 'package:yosrixia/features/child/profile/data/storage_service.dart';

class ImagePickerCubit extends Cubit<ImagePickerStates> {
  ImagePickerCubit() : super(ImagePickerInitial());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(bool isFirebaseImageEmpty) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
       File file = File(pickedFile.path);
      StorageService storageService = StorageService();
      String? imageUrl = await storageService.uploadProfileImage(file);
      if (imageUrl != null && isFirebaseImageEmpty) {
        await FirestoreService().updateUserImage(imageUrl);
      }
      emit(ImagePickerLoaded(File(pickedFile.path)));
    } else {
      emit( ImagePickerError());
    }
  }
}