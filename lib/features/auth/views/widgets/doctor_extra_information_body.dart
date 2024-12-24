import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/widgets/custom_text_form_field.dart';
import 'package:yosrixia/core/widgets/number_text_form_field.dart';
import 'package:yosrixia/features/auth/cubit/doctor_extra_info_cubit.dart';
import 'package:yosrixia/features/auth/views/widgets/custom_text_button.dart';
import 'package:yosrixia/features/auth/views/widgets/yosrixia.dart';

class DoctorExtraInformationBody extends StatelessWidget {
  const DoctorExtraInformationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorExtraInfoCubit(),
      child: BlocBuilder<DoctorExtraInfoCubit, void>(
        builder: (context, state) {
          final cubit = context.read<DoctorExtraInfoCubit>();

          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    const Yosrixia(),
                    const SizedBox(height: 75),
                    CustomTextFormField(
                      labelText: 'Organization',
                      controller: cubit.organizationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your organization';
                        }
                        if (value.length < 3) {
                          return 'Organization must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    NumberTextFormField(
                      labelText: 'Experience',
                      controller: cubit.experienceController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your experience years';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 167),
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
