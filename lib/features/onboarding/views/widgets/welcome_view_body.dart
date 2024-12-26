import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/assets_data.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/onboarding/views/widgets/start_button.dart';

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 130),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Welcome to',
              style: Styles.textStyle40.copyWith(
                color: kSecondaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Stack(children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'YOSRIXIA',
                  style: Styles.textStyle96
                      .copyWith(color: kSecondaryColor, height: 0.65),
                ),
              ),
              Image.asset(
                AssetsData.logo,
                width: double.infinity,
              ),
            ]),
            const StartButton()
          ],
        ),
      ),
    );
  }
}
