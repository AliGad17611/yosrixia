import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({super.key, required this.subLetter});
  final String subLetter;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.subCharacters);
          },
          child: Container(
            width: 148,
            height: 167,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Text(
              subLetter,
              style: Styles.textStyle64Inter,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon:
                const Icon(Icons.graphic_eq, size: 50, color: kSecondaryColor)),
      ],
    );
  }
}
