import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/widgets/custom_text_form_field.dart';
import 'package:yosrixia/features/auth/cubit/update_user_information_cubit.dart';

class BirthDatePickerWidget extends StatelessWidget {
  const BirthDatePickerWidget({
    super.key,
    required this.cubit,
  });

  final UpdateUserInformationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      labelText: 'تاريخ الميلاد',
      hintText: 'yyyy-MM-dd',
      suffixIcon: const Icon(Icons.calendar_month, color: kSecondaryColor),
      controller: cubit.birthDateController,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          cubit.birthDateController.text =
              DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال تاريخ ميلادك';
        }
        return null;
      },
    );
  }
}
