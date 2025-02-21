import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/styles.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.white,
        ),
        child: Text(
  "إذا كنت بحاجة إلى أي مساعدة، لديك استفسار، أو تواجه أي مشكلة أثناء استخدام التطبيق، لا تتردد في التواصل معنا عبر البريد الإلكتروني: \n"
  "yosrexia@gmail.com",
  style: Styles.textStyle36Passion,
),
      ),
    );
  }
}
