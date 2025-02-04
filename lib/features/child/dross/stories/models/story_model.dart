class StoryModel {
  final String textToDisplay;
  final String textToCheck;
  final List<String> imagePath;
  final String voicePath;

  StoryModel({
    required this.textToDisplay,
    required this.textToCheck,
    required this.imagePath,
    required this.voicePath,
  });
}