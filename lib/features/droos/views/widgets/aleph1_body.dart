import 'package:flutter/material.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/responsive/widget_width.dart';
import 'package:yosrixia/core/utils/assets_data.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class Aleph1Body extends StatelessWidget {
  const Aleph1Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 115),
              child: Text(
                'أَ',
                style: Styles.textStyle128Passion.copyWith(
                  height: 0.4,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Image.asset(
                    AssetsData.aleph1Arnab,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: widgetWidth(context: context, width: 78),
                      height: widgetHeight(context: context, height: 75),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            widgetWidth(context: context, width: 35))),
                        color: kPrimaryColor,
                      ),
                      child:
                          const Icon(Icons.mic, size: 40, color: kBlackColor),
                    ),
                    const Spacer(),
                    Text(
                      'أَرنب',
                      style: Styles.textStyle64Passion,
                    ),
                    const Spacer(),
                    Container(
                      width: widgetWidth(context: context, width: 78),
                      height: widgetHeight(context: context, height: 75),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            widgetWidth(context: context, width: 35))),
                        color: kPrimaryColor,
                      ),
                      child: const Icon(
                        Icons.volume_up,
                        size: 40,
                        color: kBlackColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
