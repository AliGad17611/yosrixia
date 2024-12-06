import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/auth/views/widgets/custom_text_form_field.dart';
import 'package:yosrixia/features/auth/views/widgets/yosrixia.dart';

class ParentRegisterViewBody extends StatelessWidget {
  const ParentRegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        const Yosrixia(),
        const SizedBox(
          height: 12,
        ),
        const CustomTextFormField(labelText: 'Parent Email'),
        const SizedBox(
          height: 12,
        ),
        const CustomTextFormField(labelText: 'Parent Number'),
        const SizedBox(
          height: 12,
        ),
        const CustomTextFormField(labelText: 'Password'),
        const SizedBox(
          height: 12,
        ),
        const CustomTextFormField(labelText: 'Confirm Password'),
        const SizedBox(
          height: 65,
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              'Next',
              style: Styles.textStyle32,
            ))
      ],
    )));
  }
}
