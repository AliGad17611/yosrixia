import 'package:flutter/material.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/auth/cubit/update_user_information_cubit.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    super.key,
    required this.cubit,
  });

  final UpdateUserInformationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('الدولة', style: Styles.textStyle24),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: widgetHeight(context: context, height: 50),
            padding: const EdgeInsets.symmetric(horizontal: 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: kPrimaryColor,
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              value: cubit.selectedGender.text.isEmpty
                  ? 'ذكر'
                  : cubit.selectedGender.text,
              items: <String>['ذكر', 'أنثى']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  cubit.selectedGender.text = newValue;
                }
              },
              style: Styles.textStyle24.copyWith(color: kSecondaryColor),
              dropdownColor: kPrimaryColor,
              iconEnabledColor: kSecondaryColor,
              iconSize: 40,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: kSecondaryColor,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'من فضلك اختر النوع';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
