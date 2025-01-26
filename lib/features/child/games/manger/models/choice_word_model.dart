class ChoiceWordModel {
  final String imagePath;
  final List<String> choices;
  final String correctAnswer;

  ChoiceWordModel(
      {required this.imagePath,
      required this.choices,
      required this.correctAnswer});
}
