import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/child_home_tutorial_data.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/tutorial/cubit/tutorial_state.dart';
import 'package:yosrixia/features/child/home_tutorial/cubit/child_home_tutorial_cubit.dart';

class ChildHomeTutorialOverlay extends StatelessWidget {
  const ChildHomeTutorialOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildHomeTutorialCubit, TutorialState>(
      builder: (context, state) {
        if (state is TutorialVisible) {
          final tutorialItem = childHomeTutorialData[state.currentIndex];

          return Container(
            color: Colors.black.withValues(alpha: 0.8),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'مرحبًا بك!',
                              style: Styles.textStyle48.copyWith(
                                color: kSecondaryColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<ChildHomeTutorialCubit>()
                                    .skipTutorial();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: kSecondaryColor,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Category title
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          tutorialItem.categoryName,
                          style: Styles.textStyle64Passion.copyWith(
                            color: kSecondaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Category image
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            tutorialItem.imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Description
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          tutorialItem.arabicDescription,
                          style: Styles.textStyle32.copyWith(
                            color: kSecondaryColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Progress indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          childHomeTutorialData.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == state.currentIndex
                                  ? kSecondaryColor
                                  : Colors.black.withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Skip button
                          TextButton(
                            onPressed: () {
                              context
                                  .read<ChildHomeTutorialCubit>()
                                  .skipTutorial();
                            },
                            child: Text(
                              'تخطي',
                              style: Styles.textStyle32.copyWith(
                                color: kSecondaryColor,
                              ),
                            ),
                          ),

                          // Next/Done button
                          ElevatedButton(
                            onPressed: () {
                              context.read<ChildHomeTutorialCubit>().nextStep();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kSecondaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              state.isLastStep ? 'ابدأ الآن!' : 'التالي',
                              style: Styles.textStyle32.copyWith(
                                color: kPrimaryColor,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
