import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/responsive/widget_width.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class LetterToWord extends StatelessWidget {
  const LetterToWord({super.key, required this.letter, required this.index});
  final String letter;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        globalCharacterIndex = index;
        GoRouter.of(context).push(AppRouter.aleph1);
      },
      child: Container(
        width: widgetWidth(context: context, width: 94),
        height: widgetHeight(context: context, height: 85),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            )),
        child: Text(
          letter,
          style: Styles.textStyle32Inter,
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