import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/features/child/games/identical_character/views/widgets/animated_flip_container.dart';
import 'package:yosrixia/features/child/games/identical_character/views/widgets/identical_charactercard_front.dart';
import 'package:yosrixia/features/child/games/identical_character/views/widgets/identical_character_card_back.dart';

class IdenticalCharacterCard extends StatefulWidget {
  const IdenticalCharacterCard({
    super.key,
    this.character = 'أ',
    this.onTap,
    this.isFlipped = false,
    this.isMatched = false,
  });

  final String character;
  final VoidCallback? onTap;
  final bool isFlipped;
  final bool isMatched;

  @override
  State<IdenticalCharacterCard> createState() => _IdenticalCharacterCardState();
}

class _IdenticalCharacterCardState extends State<IdenticalCharacterCard> {
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _isFlipped = widget.isFlipped;
  }

  @override
  void didUpdateWidget(IdenticalCharacterCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFlipped != oldWidget.isFlipped) {
      setState(() {
        _isFlipped = widget.isFlipped;
      });
    }
  }

  void _handleTap() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedFlipContainer(
        isFlipped: _isFlipped,
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
          character: widget.character,
          isMatched: widget.isMatched,
        ),
        onFlipComplete: () {
          // You can add logic here when flip animation completes
        },
      ),
    );
  }
}
