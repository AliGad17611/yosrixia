import 'package:flutter/material.dart';
import 'package:yosrixia/core/helper/arabic_characters_map.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/core/models/word_model.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/views/widgets/word_widget.dart';

class Aleph1Body extends StatelessWidget {
  const Aleph1Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String mainCharacter = globalMainCharacter;
    final List<String> subCharacters = globalSubCharacter;
    final int characterIndex = globalCharacterIndex;
    final PageController pageController =
        PageController(initialPage: characterIndex);

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: subCharacters.length,
        itemBuilder: (context, pageViewIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 115),
                  child: Text(
                    subCharacters[pageViewIndex],
                    style: Styles.textStyle128Passion.copyWith(
                      height: 0.4,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      WordModel? wordData = arabicCharactersMap[mainCharacter]
                          ?[subCharacters[pageViewIndex]]?[index];
                      return WordWidget(
                        wordModel: wordData ??
                            WordModel(
                              wordToDisplay: '',
                              wordToCheck: '',
                              imagePadding: 0.0,
                              imagePath: '',
                              voicePath: '',
                            ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 100),
                    itemCount: arabicCharactersMap[mainCharacter]
                                ?[subCharacters[pageViewIndex]]
                            ?.length ??
                        0,
                    padding: const EdgeInsets.only(bottom: 100),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
