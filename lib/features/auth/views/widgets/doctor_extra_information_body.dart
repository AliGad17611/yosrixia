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

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      const Yosrixia(),
                      const SizedBox(height: 75),
                      CustomTextFormField(
                        labelText: 'المنظمة',
                        controller: cubit.organizationController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك أدخل المنظمة';
                          }
                          if (value.length < 3) {
                            return 'المنظمة يجب أن تكون على الأقل 3 حروف';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      NumberTextFormField(
                        labelText: 'عدد سنوات الخبرة',
                        controller: cubit.experienceController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك أدخل عدد سنوات الخبرة';
                          }
                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                            return 'العدد يجب أن يكون عددًا';
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
            ),
          );
        },
      ),
    );
  }
}
