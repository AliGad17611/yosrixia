import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/widgets/email_text_form_field.dart';
import 'package:yosrixia/core/widgets/number_text_form_field.dart';
import 'package:yosrixia/core/widgets/password_text_form_field.dart';
import 'package:yosrixia/features/auth/cubit/register_cubit.dart';
import 'package:yosrixia/features/auth/views/widgets/custom_text_button.dart';
import 'package:yosrixia/features/auth/views/widgets/yosrixia.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key,this.extra});
final String? extra;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocBuilder<RegisterCubit, void>(
        builder: (context, state) {
          final cubit = context.read<RegisterCubit>();

          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    const Yosrixia(),
                    const SizedBox(height: 12),
                    EmailTextFormField(
                      labelText: 'Parent Email',
                      controller: cubit.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    NumberTextFormField(
                      labelText: 'Parent Number',
                      controller: cubit.numberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your number';
                        }
                        if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    PasswordTextFormField(
                      labelText: 'Password',
                      controller: cubit.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    PasswordTextFormField(
                      labelText: 'Confirm Password',
                      controller: cubit.confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 65),
                    CustomTextButton(
                      onPressed: () => cubit.validateAndSubmit(context, extra!),
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
