import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/cubit/users_cubit.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/doctor/views/widgets/child_widget.dart';
import 'package:yosrixia/features/doctor/views/widgets/doctor_header_widget.dart';

class DoctorHomeViewBody extends StatelessWidget {
  const DoctorHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const DoctorHeaderWidget(),
              Expanded(
                child: BlocBuilder<UsersCubit, UsersState>(
                  builder: (context, state) {
                    if (state is UsersLoading) {
                      return const Center(
                          child: CircularProgressIndicator()); // ✅ Better UX
                    } else if (state is UsersSuccess) {
                      return ListView.separated(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemBuilder: (context, index) {
                          return ChildWidget(user: state.usersList[index]);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 16);
                        },
                        itemCount: state.usersList.length,
                      );
                    } else if (state is UsersFailure) {
                      return const Center(child: Text('Something went wrong'));
                    }
                    return const Center(
                        child:
                            CircularProgressIndicator()); // ✅ Fallback loader
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.appointment);
                      },
                      child: Text(
                        'تحديد ميعاد',
                        style:
                            Styles.textStyle24.copyWith(color: kPrimaryColor),
                      ),
                    ),
                  ),
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            GoRouter.of(context).push(AppRouter.doctorProfile);
                          },
                          child: Text(
                            'الصفحة الشخصية',
                            style: Styles.textStyle24
                                .copyWith(color: kPrimaryColor),
                          ))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
