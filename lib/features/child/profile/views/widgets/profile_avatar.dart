import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/features/child/profile/data/image_cubit/image_picker_cubit.dart';
import 'package:yosrixia/features/child/profile/data/image_cubit/image_picker_states.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ImagePickerCubit, ImagePickerStates>(
        builder: (context, state) {
          return Container(
            height: 190,
            width: 190,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: state is ImagePickerLoaded
                      ? Image.file(
                          state.imageFile,
                          height: 190,
                          width: 190,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg',
                          height: 190,
                          width: 190,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: InkWell(
                    splashColor: kSecondaryColor,
                    onTap: () {
                      context.read<ImagePickerCubit>().pickImage();
                    },
                    child: const CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Icon(
                        Icons.camera_alt,
                        color: kSecondaryColor,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
