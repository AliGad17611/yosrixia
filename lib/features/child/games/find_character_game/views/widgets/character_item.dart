import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/games/find_character_game/manger/find_character_cubit/find_character_cubit.dart';

class CharacterItem extends StatelessWidget {
  final String character;
  final double left;
  final double top;
  final int characterId;
  final double screenWidth;
  final double screenHeight;

  const CharacterItem({
    super.key,
    required this.character,
    required this.left,
    required this.top,
    required this.characterId,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () => context
            .read<FindCharacterCubit>()
            .onCharacterTapped(screenWidth, screenHeight, characterId),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Text(
            character,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
