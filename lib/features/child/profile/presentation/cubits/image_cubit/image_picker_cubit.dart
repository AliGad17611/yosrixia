
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/logger/app_logger.dart';
import 'package:yosrixia/features/child/profile/data/repo/profile_repo.dart';
import 'package:yosrixia/features/child/profile/presentation/cubits/image_cubit/image_picker_states.dart';

class ImagePickerCubit extends Cubit<ImagePickerStates> {
  ImagePickerCubit({required ProfileRepo profileRepo})
      : _profileRepo = profileRepo,
        super(ImagePickerInitial());
  final ProfileRepo _profileRepo;

  Future<void> pickImage() async {
    emit(ImagePickerLoading());
    AppLogger.logInfo('pickImage');
    final result = await _profileRepo.updateUserImage();
    result.fold(
      (failure) => emit(ImagePickerError()),
      (file) => emit(ImagePickerLoaded(file)),
    );
  }

}
