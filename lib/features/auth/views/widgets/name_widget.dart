import 'package:flutter/material.dart';
import 'package:yosrixia/core/widgets/custom_text_form_field.dart';
import 'package:yosrixia/features/auth/cubit/update_user_information_cubit.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({
    super.key,
    required this.cubit,
  });

  final UpdateUserInformationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      labelText: 'الاسم بالكامل',
      controller: cubit.nameController,
      validator: (value) {
        RegExp arabicNameRegExp = RegExp(
            r'^[\u0621-\u064A\s]+$'); // التحقق من أن النص مكتوب بالعربية
        if (value!.isEmpty) {
          return 'الرجاء إدخال اسمك الكامل';
        } else if (!arabicNameRegExp.hasMatch(value)) {
          return 'الاسم يجب أن يكون باللغة العربية';
        } else if (!value.contains(' ') ||
            value.split(' ').length < 6) {
          return 'الرجاء إدخال الاسم بالكامل';
        }
        return null;
      },
    );
  }
}
