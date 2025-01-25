import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/views/widgets/dross_category.dart';

class GameHomeViewBody extends StatelessWidget {
  const GameHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 45, right: 16, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'ألعاب',
                style: Styles.textStyle96,
              ),
              const Spacer(
                flex: 3,
              ),
              DrossCategory(
                text: 'حروف',
                onTap: () {},
              ),
              const SizedBox(height: 46),
              DrossCategory(
                text: 'كلمات',
                onTap: () {},
              ),
              const Spacer(
                flex: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
