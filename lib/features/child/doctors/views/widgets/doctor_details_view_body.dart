import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/doctors/cubit/doctor_details_cubit.dart';
import 'package:yosrixia/features/widgets/user_avatar.dart';

class DoctorDetailsViewBody extends StatelessWidget {
  const DoctorDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorDetailsCubit()..getDoctorDetails(uid),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
            builder: (context, state) {
              if (state is DoctorDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DoctorDetailsLoaded) {
                return Column(
                  children: [
                    const Spacer(flex: 3),
                    UserAvatar(
                      role: 'doctor',
                      imageUrl: state.doctorModel.imageUrl,
                    ),
                    const Spacer(flex: 1),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'د/ ${state.doctorModel.name}',
                        style: Styles.textStyle40,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(flex: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          state.doctorModel.number,
                          style: Styles.textStyle20,
                        ),
                      ],
                    ),
                    const Spacer(flex: 1),
                    Row(
                      children: [
                        const Icon(
                          Icons.email,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          state.doctorModel.email,
                          style: Styles.textStyle20,
                        ),
                      ],
                    ),
                    const Spacer(flex: 8),
                  ],
                );
              } else if (state is DoctorDetailsFailure) {
                return Center(child: Text(state.error));
              } else {
                return const Center(child: Text('Something went wrong'));
              }
            },
          ),
        ),
      ),
    );
  }
}
