import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/profile/views/data/cubit/image_picker_cubit.dart';
import 'package:yosrixia/features/child/profile/views/widgets/profile_avatar.dart';

class ChildProfileViewBody extends StatelessWidget {
  const ChildProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagePickerCubit(),
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                const ProfileAvatar(),
                const SizedBox(height: 20),
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text('الاسم'),
                  subtitle: Text(
                    'على جاد على',
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.email),
                  title: Text('البريد الالكتروني'),
                  subtitle: Text('aligad@gmail.com'),
                ),
                const ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('الهاتف'),
                  subtitle: Text(
                    '01061121037',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.right,
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.people),
                  title: Text('النوع'),
                  subtitle: Text('ولد'),
                ),
                const ListTile(
                  leading: Icon(Icons.cake),
                  title: Text('تاريخ الميلاد'),
                  subtitle: Text('11/11/2022'),
                ),
                const ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('الدولة'),
                  subtitle: Text('مصر'),
                ),
                Row(spacing: 10, mainAxisSize: MainAxisSize.min, children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.assignment_outlined),
                  Text(
                    'اجابات الاختبارات',
                    style: Styles.textStyle20
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
