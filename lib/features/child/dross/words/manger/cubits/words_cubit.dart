import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/arabic_characters_map.dart';
import 'package:yosrixia/core/models/word_model.dart';

class WordsCubit extends Cubit<List<WordModel>> {
  WordsCubit() : super([]);


  void loadCharacterData(String mainCharacter, String subCategory) {
    final wordList = arabicCharactersMap[mainCharacter]?[subCategory] ?? [];
    emit(wordList);
  }
}
