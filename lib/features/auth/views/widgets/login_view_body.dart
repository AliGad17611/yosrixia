import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/core/widgets/email_text_form_field.dart';
import 'package:yosrixia/core/widgets/password_text_form_field.dart';
import 'package:yosrixia/features/auth/cubit/login_state.dart';
import 'package:yosrixia/features/auth/views/widgets/yosrixia.dart';
import 'package:yosrixia/features/widgets/custom_button.dart';
import 'package:yosrixia/features/auth/cubit/login_cubit.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              // Navigate to the appropriate role-based screen
              switch (state.role) {
                case 'child':
                  GoRouter.of(context).go(AppRouter.childHome);
                  break;
                case 'doctor':
                  GoRouter.of(context).go(AppRouter.doctorHome);
                  break;
                case 'support':
                  GoRouter.of(context).push(AppRouter.selectRole);
                  break;
                default:
                  GoRouter.of(context).push(AppRouter.selectRole);
              }
            } else if (state is LoginFailure) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              final cubit = context.read<LoginCubit>();
              return SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      const Yosrixia(),
                      Text(
                        'Login',
                        style: Styles.textStyle40.copyWith(height: 0.7),
                      ),
                      const SizedBox(height: 40),
                      EmailTextFormField(
                        labelText: 'Email',
                        controller: cubit.emailController,
                        validator: cubit.validateEmail,
                      ),
                      const SizedBox(height: 24),
                      PasswordTextFormField(
                        labelText: 'Password',
                        controller: cubit.passwordController,
                        validator: cubit.validatePassword,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 28),
                          child: InkWell(
                            onTap: () {
                              GoRouter.of(context)
                                  .push(AppRouter.parentRegister);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: Styles.textStyle24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 33),
                      state is LoginLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                              onPressed: () {
                                if (cubit.validateForm()) {
                                  cubit.loginUser();
                                }
                              },
                            ),
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
            },
          ),
        ),
      ),
    );
  }
}
