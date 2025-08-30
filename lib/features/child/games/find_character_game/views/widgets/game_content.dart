import 'package:flutter/material.dart';
import 'package:yosrixia/core/widgets/title_widget.dart';
import 'package:yosrixia/features/child/games/find_character_game/manger/find_character_cubit/find_character_cubit.dart';
import 'package:yosrixia/features/child/games/find_character_game/views/widgets/character_item.dart';
import 'package:yosrixia/features/child/games/find_character_game/views/widgets/progress_and_refresh_row.dart';

class GameContent extends StatelessWidget {
  final FindCharacterGameState state;
  final double screenWidth;
  final double screenHeight;

  const GameContent({
    super.key,
    required this.state,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            state.backgroundImage,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          // Game Title
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 24, right: 24),
            child: TitleWidget(
              title: 'ابحث عن حرف ال ${state.currentCharacter}',
            ),
          ),

          // Game Progress Display
          ProgressAndRefreshRow(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            remainingCharacters: state.remainingCharacters,
          ),

          // Characters positioned randomly
          ...state.characterPositions
              .where((position) => position.isVisible)
              .map(
                (position) => CharacterItem(
                  character: state.currentCharacter,
                  left: position.left,
                  top: position.top,
                  characterId: position.id,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
              ),
        ],
      ),
    );
  }
}
