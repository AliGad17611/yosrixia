import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/widgets/email_text_form_field.dart';
import 'package:yosrixia/core/widgets/number_text_form_field.dart';
import 'package:yosrixia/core/widgets/password_text_form_field.dart';
import 'package:yosrixia/features/auth/cubit/register_cubit.dart';
import 'package:yosrixia/features/auth/views/widgets/custom_text_button.dart';
import 'package:yosrixia/features/auth/views/widgets/yosrixia.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key, this.extra});
  final String? extra;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocBuilder<RegisterCubit, void>(
        builder: (context, state) {
          final cubit = context.read<RegisterCubit>();

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      const Yosrixia(),
                      const SizedBox(height: 12),
                      EmailTextFormField(
                        labelText: 'البريد الإلكتروني',
                        controller: cubit.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك أدخل بريدك الإلكتروني';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'من فضلك أدخل بريدك الإلكتروني صالح';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      NumberTextFormField(
                        labelText: 'رقم الهاتف',
                        controller: cubit.numberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك أدخل رقمك';
                          }
                          if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
                            return 'من فضلك أدخل رقمك صالح';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      PasswordTextFormField(
                        labelText: 'كلمة المرور',
                        controller: cubit.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك أدخل كلمة المرور';
                          }
                          if (value.length < 8) {
                            return 'كلمة المرور يجب أن تكون أكثر من 8 حروف';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      PasswordTextFormField(
                        labelText: 'تأكيد كلمة المرور',
                        controller: cubit.confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك أدخل كلمة المرور';
                          }
                          if (value != cubit.passwordController.text) {
                            return 'كلمة المرور غير متطابقه';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 65),
                      CustomTextButton(
                        onPressed: () =>
                            cubit.validateAndSubmit(context, extra!),
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
