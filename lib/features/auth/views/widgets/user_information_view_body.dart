import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/widgets/custom_text_form_field.dart';
import 'package:yosrixia/core/widgets/number_text_form_field.dart';
import 'package:yosrixia/features/auth/cubit/update_user_information_cubit.dart';
import 'package:yosrixia/features/auth/views/widgets/custom_text_button.dart';
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

          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    const Yosrixia(),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      labelText: 'Name',
                      controller: cubit.nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.length < 3) {
                          return 'Name must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      labelText: 'Country',
                      controller: cubit.countryController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your country';
                        }
                        if (value.length < 3) {
                          return 'Country must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    NumberTextFormField(
                      labelText: 'Age',
                      controller: cubit.ageController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      labelText: 'Gender',
                      controller: cubit.genderController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your gender';
                        }
                        if (value.toLowerCase() != 'male' &&
                            value.toLowerCase() != 'female') {
                          return 'Gender must be either "male" or "female"';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 65),
                    CustomTextButton(
                      onPressed: () => cubit.validateAndSubmit(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
