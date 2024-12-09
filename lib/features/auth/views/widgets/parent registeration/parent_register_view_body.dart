import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/widgets/email_text_form_field.dart';
import 'package:yosrixia/core/widgets/number_text_form_field.dart';
import 'package:yosrixia/core/widgets/password_text_form_field.dart';
import 'package:yosrixia/features/auth/views/widgets/custom_text_button.dart';
import 'package:yosrixia/features/auth/views/widgets/yosrixia.dart';

class ParentRegisterViewBody extends StatelessWidget {
  const ParentRegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Yosrixia(),
        SizedBox(
          height: 12,
        ),
        EmailTextFormField(labelText: 'Parent Email'),
        SizedBox(
          height: 12,
        ),
        NumberTextFormField(labelText: 'Parent Number'),
        SizedBox(
          height: 12,
        ),
        PasswordTextFormField(labelText: 'Password'),
        SizedBox(
          height: 12,
        ),
        PasswordTextFormField(labelText: 'Confirm Password'),
        SizedBox(
          height: 65,
        ),
        CustomTextButton(nextRoute: AppRouter.parentEmailConfirmation,)
      ],
    )));
  }
}
