import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/responsive/widget_width.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/assets_data.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class ChildRole extends StatelessWidget {
  const ChildRole({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(AppRouter.parentRegister);
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
              top: widgetHeight(context: context, height: -55),
              child: Image.asset(
                AssetsData.child,
                width: widgetWidth(context: context, width: 190),
              ),
            ),
            Positioned(
              top: widgetHeight(context: context, height: 185),
              child: Text(
                'Child',
                style: Styles.textStyle40Passion.copyWith(color: kBlueColor),
              ),
            )
          ])),
    );
  }
}
