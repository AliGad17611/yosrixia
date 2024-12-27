import 'package:yosrixia/core/helper/arabic_characters_map.dart';

String globalMainCharacter = '';
List<String> globalSubCharacter =
    arabicCharactersMap[globalMainCharacter]!.keys.toList();
int globalCharacterIndex = 0;
