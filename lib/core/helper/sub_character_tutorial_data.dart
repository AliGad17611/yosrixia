import 'package:yosrixia/core/models/tutorial_model.dart';
import 'package:yosrixia/core/utils/assets_data.dart';

List<TutorialModel> subCharacterTutorialData = [
  TutorialModel(
    categoryName: 'أشكال الحرف',
    description: 'تعرف على الأشكال المختلفة للحرف',
    arabicDescription:
        'كل حرف عربي له أشكال مختلفة حسب موقعه في الكلمة. ستتعلم هنا الأشكال الأربعة للحرف: في بداية الكلمة، في وسط الكلمة، في نهاية الكلمة، أو منفرداً.',
    imagePath: AssetsData.lessons,
  ),
  TutorialModel(
    categoryName: 'استمع للنطق',
    description: 'اضغط على الحرف لسماع نطقه',
    arabicDescription:
        'يمكنك الضغط على أي شكل من أشكال الحرف في الأعلى لسماع نطقه الصحيح. هذا يساعد على تعلم الصوت الصحيح لكل حرف.',
    imagePath: AssetsData.lessons,
  ),
  TutorialModel(
    categoryName: 'الكلمات والأمثلة',
    description: 'اكتشف الكلمات التي تحتوي على الحرف',
    arabicDescription:
        'في الأسفل، يمكنك الضغط على كل شكل من أشكال الحرف لرؤية كلمات تحتوي على هذا الشكل. هذا يساعد على فهم استخدام الحرف في الكلمات الحقيقية.',
    imagePath: AssetsData.lessons,
  ),
  TutorialModel(
    categoryName: 'ابدأ التعلم',
    description: 'جرب الآن وتفاعل مع الحروف',
    arabicDescription:
        'الآن يمكنك البدء! اضغط على الحروف في الأعلى لسماع نطقها، واضغط على الحروف في الأسفل لرؤية الكلمات. تدرب واستمتع بالتعلم!',
    imagePath: AssetsData.lessons,
  ),
];
