import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/global_variable.dart';

class CharacterState {
  final String mainCharacter;
  final List<String> subCharacters;
  final int characterIndex;

  CharacterState({
    required this.mainCharacter,
    required this.subCharacters,
    required this.characterIndex,
  });
}

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit()
      : super(CharacterState(
          mainCharacter: globalMainCharacter,
          subCharacters: globalSubCharacter,
          characterIndex: globalCharacterIndex,
        ));

  void updateMainCharacter(String newCharacter) {
    emit(CharacterState(
      mainCharacter: newCharacter,
      subCharacters: globalSubCharacter,
      characterIndex: globalCharacterIndex,
    ));
  }
}
