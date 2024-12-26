import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/sub_characters_map.dart';
import 'package:yosrixia/core/models/character_model.dart';

class SubCharactersCubit extends Cubit<List<CharacterModel>>{
  SubCharactersCubit() : super([]);


  void loadSubCharacterData(String mainCharacter) {
    final subCategories = subCharactersMap[mainCharacter] ?? [];
    emit(subCategories);
  }
}