import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class LetterButton extends StatelessWidget {
  const LetterButton({super.key, required this.letter});
  final String letter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        globalMainCharacter = letter;
        log(globalMainCharacter);
        letter == ''
            ? null
            : GoRouter.of(context).push(AppRouter.subCharacters);
      },
      child: Container(
        width: 97,
        height: 97,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: letter == '' ? Colors.transparent : kPrimaryColor,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Text(
          letter,
          style: Styles.textStyle64Inter,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


  
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Text(
//         letter,
//         style: const TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }