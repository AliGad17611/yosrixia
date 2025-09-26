import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/spacing.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/core/widgets/password_text_form_field.dart';
import 'package:yosrixia/features/widgets/custom_button.dart';

class ParentProfileViewBody extends StatelessWidget {
  const ParentProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                verticalSpace(90),
                Text(
                    "هذا القسم مخصص لأولياء الأمور فقط.\nيرجى إدخال كلمة المرور الخاصة بك للمتابعة.",
                    style: Styles.textStyle24),
                verticalSpace(40),
                PasswordTextFormField(
                  labelText: 'كلمة المرور:',
                  controller: TextEditingController(),
                  validator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال كلمة المرور' : null,
                  horizontalPadding: 0,
                ),
                verticalSpace(40),
                CustomButton(
                  width: 200.w,
                  height: 60.h,
                  textColor: kBlackColor,
                  onPressed: () {},
                  text: 'تاكيد',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
