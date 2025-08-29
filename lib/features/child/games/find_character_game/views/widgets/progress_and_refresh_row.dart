import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/spacing.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/games/find_character_game/manger/find_character_cubit/find_character_cubit.dart';

class ProgressAndRefreshRow extends StatelessWidget {
  const ProgressAndRefreshRow({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.remainingCharacters,
  });

  final double screenWidth;
  final double screenHeight;
  final int remainingCharacters;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 150,
      left: 24,
      right: 24,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: kLightWhiteColor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'المتبقي : $remainingCharacters',
                    style: Styles.textStyle20.copyWith(
                        color: kLightBlackColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            horizontalSpace(30),
            IconButton(
              onPressed: () {
                context
                    .read<FindCharacterCubit>()
                    .resetCharactersPositions(screenWidth, screenHeight);
              },
              style: IconButton.styleFrom(
                backgroundColor: kLightWhiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              icon: const Icon(
                Icons.refresh,
                color: kLightBlackColor,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
