
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/games/helper/word_completion_list.dart';
import 'package:yosrixia/features/child/games/manger/cubit/game_state.dart';


class WordCompletionCubit extends Cubit<GameState> {
  WordCompletionCubit() : super(InitialGameState());
  final int  totalQuestions = wordList.length;
   int score = 0;
   int index = 0;

  void selectOption(int selectedIndex) {
    final currentQuestion = wordList[index];
    final isCorrect = currentQuestion.correctChoice == currentQuestion.choices[selectedIndex];
    final int correctAnswerIndex = currentQuestion.choices.indexOf(currentQuestion.correctChoice);

    if (isCorrect) {
      score++;
      emit(CorrectAnswerState(questionIndex: index, selectedIndex: selectedIndex));
    } else {
      emit(WrongAnswerState(questionIndex: index, selectedIndex: selectedIndex, correctAnswerIndex: correctAnswerIndex)); 
    }
    if (index < totalQuestions - 1) {
      Future.delayed(const Duration(seconds: 2), () {
        index++;
        emit(NextQuestionState(index: index));
      });
    }
    else {
      Future.delayed(const Duration(seconds: 2), () {
        emit(FinalScoreState(score: score));
      });
    }

  }

}
