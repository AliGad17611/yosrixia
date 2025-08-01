import 'package:yosrixia/core/models/tutorial_model.dart';
import 'package:yosrixia/core/utils/assets_data.dart';

List<TutorialModel> childHomeTutorialData = [
  TutorialModel(
    categoryName: 'دروس',
    description: 'تعلم الحروف والكلمات والجمل والقصص',
    arabicDescription:
        'قسم الدروس يحتوي على تعليم الحروف العربية والكلمات والجمل والقصص التفاعلية. سيساعد طفلك على تطوير مهارات القراءة والكتابة بطريقة ممتعة وتفاعلية مع الأصوات والصور.',
    imagePath: AssetsData.lessons,
  ),
  TutorialModel(
    categoryName: 'العاب تعليمية',
    description: 'ألعاب ممتعة لتعزيز التعلم',
    arabicDescription:
        'مجموعة متنوعة من الألعاب التعليمية الممتعة التي تساعد طفلك على التعلم من خلال اللعب. تشمل ألعاب الحروف والكلمات والذاكرة والألغاز التي تطور المهارات المعرفية.',
    imagePath: AssetsData.games,
  ),
  TutorialModel(
    categoryName: 'أطباء',
    description: 'تواصل مع المختصين في عسر القراءة',
    arabicDescription:
        'يمكنك هنا التواصل مع الأطباء والمختصين في علاج عسر القراءة للحصول على الاستشارة والمساعدة المهنية. سيساعدونك في متابعة تطور طفلك وتقديم النصائح المناسبة.',
    imagePath: AssetsData.doctors,
  ),
  TutorialModel(
    categoryName: 'نصائح',
    description: 'نصائح مفيدة للآباء والمعلمين',
    arabicDescription:
        'قسم النصائح يحتوي على إرشادات مهمة للآباء والمعلمين حول كيفية التعامل مع الأطفال الذين يعانون من عسر القراءة وطرق دعمهم وتشجيعهم على التعلم.',
    imagePath: AssetsData.tips,
  ),
];
