import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/responsive/widget_width.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/assets_data.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class DoctorRole extends StatelessWidget {
  const DoctorRole({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(AppRouter.parentRegister, extra: 'doctor');
      },
      child: Container(
          width: widgetWidth(context: context, width: 344),
          height: widgetHeight(context: context, height: 246),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(widgetWidth(context: context, width: 40)),
            ),
          ),
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
              top: widgetHeight(context: context, height: -20),
              child: Image.asset(
                AssetsData.doctor,
                width: widgetWidth(context: context, width: 250),
              ),
            ),
            Positioned(
              top: widgetHeight(context: context, height: 180),
              child: Text(
                'طبيب',
                style: Styles.textStyle40Passion.copyWith(color: kBlueColor),
              ),
            )
          ])),
    );
  }
}
