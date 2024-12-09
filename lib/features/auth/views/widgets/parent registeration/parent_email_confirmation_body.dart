import 'package:flutter/material.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/responsive/widget_width.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/core/widgets/number_text_form_field.dart';
import 'package:yosrixia/features/auth/views/widgets/custom_text_button.dart';
import 'package:yosrixia/features/auth/views/widgets/yosrixia.dart';

class ParentEmailConfirmationBody extends StatelessWidget {
  const ParentEmailConfirmationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Yosrixia(),
          Column(
            children: [
              const NumberTextFormField(labelText: 'Confirmation Code'),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widgetWidth(context: context, width: 23)),
                child: Text('write the code that you get on your email',
                    style: Styles.textStyle24),
              ),
            ],
          ),
          Column(
            children: [
              const CustomTextButton(nextRoute: AppRouter.parentRegister),
              SizedBox(height: widgetHeight(context: context, height: 59)),
            ],
          ),
        ],
      ),
    );
  }
}
