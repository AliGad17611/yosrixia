import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/assets_data.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/droos/views/widgets/word_widget.dart';

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
            const WordWidget(imagePath: AssetsData.aleph1Arnab, wordToMatch: 'ارنب', wordToDisplay: 'أَرنب',),
          ],
        ),
      ),
    );
  }
}
