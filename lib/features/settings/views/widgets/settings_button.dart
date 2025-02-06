import 'package:flutter/material.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton(
      {super.key, required this.text, required this.onTap, required this.icon});

  final String text;
  final void Function() onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: widgetHeight(context: context, height: 93),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: kPrimaryColor,
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(icon, size: 50, color: kSecondaryColor),
              const Spacer(flex: 1),
              Text(text,
                  style: Styles.textStyle40Passion
                      .copyWith(color: const Color(0xFF53ACDE))),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
