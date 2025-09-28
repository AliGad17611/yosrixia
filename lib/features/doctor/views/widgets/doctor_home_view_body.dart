import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/cubit/users_cubit.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}
