import 'package:flutter/material.dart';
import 'package:yosrixia/core/helper/arabic_characters_map.dart';
import 'package:yosrixia/core/models/word_model.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/views/widgets/word_widget.dart';

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
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => WordWidget(
                        wordModel: arabicCharactersMap['أ']?['أَ']?[index] ??
                            WordModel(
                              wordToDisplay: '',
                              wordToCheck: '',
                              imagePadding: 0.0,
                              imagePath: '',
                              voicePath: '',
                            ),
                      ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: arabicCharactersMap['أ']?['أَ']?.length ?? 0),
            )
          ],
        ),
      ),
    );
  }
}
