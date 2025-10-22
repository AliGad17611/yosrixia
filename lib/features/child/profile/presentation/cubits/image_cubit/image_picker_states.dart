import 'dart:io';

class ImagePickerStates {}

class ImagePickerInitial extends ImagePickerStates {}

class ImagePickerLoaded extends ImagePickerStates {
  final File file;
  ImagePickerLoaded(this.file);
}

class ImagePickerError extends ImagePickerStates {}

class ImagePickerLoading extends ImagePickerStates {

}