import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/auth/views/widgets/custom_text_form_field.dart';
import 'package:yosrixia/features/auth/views/widgets/yosrixia.dart';
import 'package:yosrixia/features/widgets/custom_button.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Yosrixia(),
            Text(
              'Login',
              style: Styles.textStyle40.copyWith(height: 0.7),
            ),
            const SizedBox(height: 40),
            const CustomTextFormField(labelText: 'Email'),
            const SizedBox(height: 24),
            const CustomTextFormField(labelText: 'Password'),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 28),
                child: Text(
                  'Forgot Password?',
                  style: Styles.textStyle24,
                ),
              ),
            ),
            const SizedBox(height: 33),
            const CustomButton(),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                GoRouter.of(context).push(AppRouter.selectRole);
              },
              child: Text(
                'Create Account',
                style: Styles.textStyle32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
