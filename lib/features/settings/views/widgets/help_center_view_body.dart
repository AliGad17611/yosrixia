import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/settings/views/widgets/help_center.dart';

class HelpCenterViewBody extends StatelessWidget {
  const HelpCenterViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              Text(
                'مركز المساعدة',
                style: Styles.textStyle96.copyWith(fontSize: 68),
              ),
              const Spacer(
                flex: 1,
              ),
              const HelpCenter(),
              const Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
