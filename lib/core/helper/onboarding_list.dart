import 'package:yosrixia/core/models/onboarding_model.dart';
import 'package:yosrixia/core/utils/assets_data.dart';

List<OnboardingModel> onboardingList = [
  OnboardingModel(
      text: 'مرحبًا بكم في يُسريكسيا!',
      imagePath: AssetsData.childOnboardingPage1),
  OnboardingModel(
      text: 'أنا يسري, و سأساعد طفلكم خلال رحلته مع عسر القراءة',
      imagePath: AssetsData.childOnboardingPage2),
  OnboardingModel(
      text:
          'لكن قبل ذلك, نحتاج لقياس مستوى عسر القراءة لدى الطفل؛ لمعرفة النقاط التي يجب التركيز عليها',
      imagePath: AssetsData.childOnboardingPage3),
  OnboardingModel(
      text:
          'و سيتم ذلك من خلال اجابة ولي الأمر أو معلم اللغة العربية للطالب على بعض الاسئلة البسيطة التي وضعها دكاترة مختصين.',
      imagePath: AssetsData.childOnboardingPage4),
  OnboardingModel(
      text: 'شكرًا لإجابتك على الأسئلة. الآن, دعنا نبدأ رحلتنا معًا.',
      imagePath: AssetsData.childOnboardingPage5),
];
