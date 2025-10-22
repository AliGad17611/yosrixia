import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/di/dependency_injection.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/profile/data/repo/profile_repo.dart';
import 'package:yosrixia/features/child/profile/presentation/cubits/child_info_cubit/child_info_cubit.dart';
import 'package:yosrixia/features/child/profile/presentation/cubits/image_cubit/image_picker_cubit.dart';
import 'package:yosrixia/features/child/profile/presentation/views/widgets/profile_avatar.dart';

class ChildProfileViewBody extends StatelessWidget {
  const ChildProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) => ChildInfoCubit(profileRepo: getIt<ProfileRepo>())..fetchChildInfo(),
          child: Scaffold(
            body: BlocBuilder<ChildInfoCubit, ChildInfoState>(
              builder: (context, state) {
                if (state is ChildInfoLoading) {
                  return const Center(
                      child: CircularProgressIndicator()); // ✅ Better UX
                }
                if (state is ChildInfoLoaded) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    children: [
                      BlocProvider(
                        create: (context) => ImagePickerCubit(profileRepo: getIt<ProfileRepo>()),
                        child: ProfileAvatar(
                          imageUrl: state.childProfileModel.imageUrl,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('الاسم'),
                        subtitle: Text(
                          state.childProfileModel.name,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('البريد الالكتروني'),
                        subtitle: Text(
                          state.childProfileModel.email,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: const Text('الهاتف'),
                        subtitle: Text(
                          state.childProfileModel.number,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.people),
                        title: const Text('النوع'),
                        subtitle: Text(state.childProfileModel.gender),
                      ),
                      ListTile(
                        leading: const Icon(Icons.cake),
                        title: const Text('تاريخ الميلاد'),
                        subtitle: Text(state.childProfileModel.birthDate),
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_on),
                        title: const Text('الدولة'),
                        subtitle: Text(state.childProfileModel.country),
                      ),
                      Row(
                          spacing: 10,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 10),
                            const Icon(Icons.assignment_outlined),
                            Text(
                              'اجابات الاختبارات',
                              style: Styles.textStyle20.copyWith(
                                  decoration: TextDecoration.underline),
                            ),
                          ]),
                    ],
                  );
                }
                return const Center(
                    child: Text('Something went wrong')); // ✅ Better UX
              },
            ),
          ),
        ),
      ),
    );
  }
}
