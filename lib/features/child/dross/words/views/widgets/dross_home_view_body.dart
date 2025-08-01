import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/tutorial/cubit/tutorial_cubit.dart';
import 'package:yosrixia/features/child/dross/tutorial/cubit/tutorial_state.dart';
import 'package:yosrixia/features/child/dross/tutorial/widgets/tutorial_overlay.dart';
import 'package:yosrixia/features/widgets/category.dart';

class DrossHomeViewBody extends StatefulWidget {
  const DrossHomeViewBody({super.key});

  @override
  State<DrossHomeViewBody> createState() => _DrossHomeViewBodyState();
}

class _DrossHomeViewBodyState extends State<DrossHomeViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TutorialCubit()..checkTutorialStatus(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Stack(
            children: [
              // Main content
              Padding(
                padding: const EdgeInsets.only(top: 45, right: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'دروس',
                      style: Styles.textStyle96,
                    ),
                    const SizedBox(height: 126),
                    Category(
                      text: 'حروف و كلمات',
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.characters);
                      },
                    ),
                    const SizedBox(height: 46),
                    Category(
                        text: 'جمل',
                        onTap: () {
                          GoRouter.of(context).push(AppRouter.gomalHome);
                        }),
                    const SizedBox(height: 46),
                    Category(
                        text: 'قصص',
                        onTap: () {
                          GoRouter.of(context).push(AppRouter.storiesHome);
                        }),
                  ],
                ),
              ),
              // Tutorial overlay
              BlocBuilder<TutorialCubit, TutorialState>(
                builder: (context, state) {
                  if (state is TutorialVisible) {
                    return const TutorialOverlay();
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
