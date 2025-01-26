class WordCompletion {
  final String incompleteWord;
  final List<String> choices;
  final String correctChoice;

  WordCompletion({
    required this.incompleteWord,
    required this.choices,
    required this.correctChoice,
  });
}
