import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/characters_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class CharactersView extends StatelessWidget {
  const CharactersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGround(child: CharactersViewBody() ,);
  }
}