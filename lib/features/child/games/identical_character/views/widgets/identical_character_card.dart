import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/features/child/games/identical_character/views/widgets/animated_flip_container.dart';
import 'package:yosrixia/features/child/games/identical_character/views/widgets/identical_charactercard_front.dart';
import 'package:yosrixia/features/child/games/identical_character/views/widgets/identical_character_card_back.dart';

class IdenticalCharacterCard extends StatelessWidget {
  const IdenticalCharacterCard({
    super.key,
    this.character = 'أ',
    this.onTap,
    this.isFlipped = false,
    this.isMatched = false,
    this.isProcessing = false,
  });

  final String character;
  final VoidCallback? onTap;
  final bool isFlipped;
  final bool isMatched;
  final bool isProcessing;

  void _handleTap() {
    // Don't allow tapping if the card is matched, already flipped, or processing
    if (isMatched || isFlipped || isProcessing) return;
    onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedFlipContainer(
        isFlipped: isFlipped,
        frontChild: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(35),
            border: Border.all(
              color: kSecondaryColor,
              width: 2,
            ),
          ),
          child: const IdenticalCharactercardFront(),
        ),
        backChild: IdenticalCharacterCardBack(
          character: character,
          isMatched: isMatched,
        ),
        onFlipComplete: () {
          // You can add logic here when flip animation completes
        },
      ),
    );
  }
}
