import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/helper/sign_up_method.dart';
import 'package:yosrixia/core/utils/app_router.dart';

class RegisterCubit extends Cubit<void> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegisterCubit() : super(null);

  void validateAndSubmit(BuildContext context, String role) {
    if (formKey.currentState?.validate() ?? false) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('كلمة المرور غير متطابقه')),
        );
        return;
      }

      signUpUser(emailController.text, passwordController.text, role, numberController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم التسجيل بنجاح')),
      );
      // Navigate to the confirmation screen
      GoRouter.of(context).push(AppRouter.userInformation);
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    numberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
