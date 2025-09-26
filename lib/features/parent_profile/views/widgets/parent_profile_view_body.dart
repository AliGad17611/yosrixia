import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/spacing.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/core/widgets/password_text_form_field.dart';
import 'package:yosrixia/features/widgets/custom_button.dart';
import 'package:yosrixia/features/parent_profile/cubit/parent_auth_cubit.dart';

class ParentProfileViewBody extends StatefulWidget {
  const ParentProfileViewBody({super.key});

  @override
  State<ParentProfileViewBody> createState() => _ParentProfileViewBodyState();
}

class _ParentProfileViewBodyState extends State<ParentProfileViewBody> {
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _handlePasswordSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context
          .read<ParentAuthCubit>()
          .validateParentPassword(_passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: BlocConsumer<ParentAuthCubit, ParentAuthState>(
              listener: (context, state) {
                if (state is ParentAuthSuccess) {
                  GoRouter.of(context).push(AppRouter.childTracker);
                } else if (state is ParentAuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(state.message),
                      ),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      verticalSpace(40),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () => GoRouter.of(context).pop(),
                          icon: Icon(
                            Icons.keyboard_double_arrow_left,
                            size: 40.sp,
                          ),
                          color: kLightWhiteColor,
                        ),
                      ),
                      const Spacer(flex: 4),
                      Text(
                        "هذا القسم مخصص لأولياء الأمور فقط.\nيرجى إدخال كلمة المرور الخاصة بك للمتابعة.",
                        style: Styles.textStyle24,
                      ),
                      const Spacer(flex: 3),
                      PasswordTextFormField(
                        labelText: 'كلمة المرور:',
                        controller: _passwordController,
                        validator: (value) =>
                            value!.isEmpty ? 'يرجى إدخال كلمة المرور' : null,
                        horizontalPadding: 0,
                      ),
                      const Spacer(flex: 2),
                      CustomButton(
                        width: state is ParentAuthLoading ? 300.w : 200.w,
                        height: 60.h,
                        textColor: kBlackColor,
                        onPressed: state is ParentAuthLoading
                            ? () {}
                            : _handlePasswordSubmit,
                        text: state is ParentAuthLoading
                            ? 'جاري التحقق...'
                            : 'دخول',
                      ),
                      const Spacer(flex: 14),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
