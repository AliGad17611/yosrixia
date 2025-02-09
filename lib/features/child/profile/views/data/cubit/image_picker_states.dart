import 'dart:io';

class ImagePickerStates {}

class ImagePickerInitial extends ImagePickerStates {}

class ImagePickerLoaded extends ImagePickerStates {
  final File imageFile;
  ImagePickerLoaded(this.imageFile);
}

class ImagePickerError extends ImagePickerStates {}