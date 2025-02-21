import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/profile/data/child_info_cubit/child_info_cubit.dart';
import 'package:yosrixia/features/child/profile/data/image_cubit/image_picker_cubit.dart';
import 'package:yosrixia/features/child/profile/views/widgets/profile_avatar.dart';

class ChildProfileViewBody extends StatelessWidget {
  const ChildProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) => ChildInfoCubit()..fetchChildInfo(),
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
                        create: (context) => ImagePickerCubit(),
                        child: ProfileAvatar(
                          imageUrl: state.childInfoModel.imageUrl,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('الاسم'),
                        subtitle: Text(
                          state.childInfoModel.name,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('البريد الالكتروني'),
                        subtitle: Text(
                          state.childInfoModel.email,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: const Text('الهاتف'),
                        subtitle: Text(
                          state.childInfoModel.number,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.people),
                        title: const Text('النوع'),
                        subtitle: Text(state.childInfoModel.gender),
                      ),
                      ListTile(
                        leading: const Icon(Icons.cake),
                        title: const Text('تاريخ الميلاد'),
                        subtitle: Text(state.childInfoModel.birthDate),
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_on),
                        title: const Text('الدولة'),
                        subtitle: Text(state.childInfoModel.country),
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
