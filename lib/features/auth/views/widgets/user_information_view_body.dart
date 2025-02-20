import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/auth/cubit/update_user_information_cubit.dart';
import 'package:yosrixia/features/auth/views/widgets/birth_date_picker_widget.dart';
import 'package:yosrixia/features/auth/views/widgets/country_widget.dart';
import 'package:yosrixia/features/auth/views/widgets/custom_text_button.dart';
import 'package:yosrixia/features/auth/views/widgets/gender_widget.dart';
import 'package:yosrixia/features/auth/views/widgets/name_widget.dart';
import 'package:yosrixia/features/auth/views/widgets/yosrixia.dart';

class UserInformationViewBody extends StatelessWidget {
  const UserInformationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateUserInformationCubit(),
      child: BlocBuilder<UpdateUserInformationCubit, void>(
        builder: (context, state) {
          final cubit = context.read<UpdateUserInformationCubit>();

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      const Yosrixia(),
                      const SizedBox(height: 12),
                      NameWidget(cubit: cubit),
                      const SizedBox(height: 12),
                      CountryWidget(cubit: cubit),
                      const SizedBox(height: 12),
                      BirthDatePickerWidget(cubit: cubit),
                      const SizedBox(height: 12),
                      GenderWidget(cubit: cubit),
                      const SizedBox(height: 65),
                      CustomTextButton(
                        onPressed: () => cubit.validateAndSubmit(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
