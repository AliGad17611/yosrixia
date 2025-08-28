import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/spacing.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/core/widgets/title_widget.dart';
import 'package:yosrixia/features/child/games/find_character_game/manger/find_character_cubit/find_character_cubit.dart';
import 'package:yosrixia/features/child/games/find_character_game/manger/helper/images_list.dart';

class FindCharacterViewBody extends StatefulWidget {
  const FindCharacterViewBody({super.key});

  @override
  State<FindCharacterViewBody> createState() => _FindCharacterViewBodyState();
}

class _FindCharacterViewBodyState extends State<FindCharacterViewBody> {
  bool _imagesPrecached = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache images only once when dependencies are available
    if (!_imagesPrecached) {
      for (var path in imagesList) {
        precacheImage(AssetImage(path), context);
      }
      _imagesPrecached = true;
    }
  }

  void showSuccessMessage(BuildContext context, String character) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor:
          Colors.black.withValues(alpha: 0.3), // Semi-transparent overlay
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Success Icon and Title
                    const Text(
                      '🎉',
                      style: TextStyle(fontSize: 48),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'أحسنت!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'لقد وجدت جميع الأحرف بنجاح!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              context
                                  .read<FindCharacterCubit>()
                                  .initializeGame(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 3,
                            ),
                            child: const Text(
                              'لعب مرة أخرى',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pop(); // Go back to previous screen
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 3,
                            ),
                            child: const Text(
                              'الخروج',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FindCharacterCubit, FindCharacterState>(
      listener: (context, state) {
        if (state is FindCharacterGameState && state.isGameCompleted) {
          showSuccessMessage(context, state.currentCharacter);
        } else if (state is FindCharacterError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<FindCharacterCubit, FindCharacterState>(
        builder: (context, state) {
          // Initialize game on first build
          if (state is FindCharacterInitial) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<FindCharacterCubit>().initializeGame(context);
            });
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Loading state
          if (state is FindCharacterLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Error state
          if (state is FindCharacterError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'حدث خطأ: ${state.message}',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<FindCharacterCubit>()
                            .initializeGame(context);
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Game state
          if (state is FindCharacterGameState) {
            return Scaffold(
              body: Stack(
                children: [
                  // Background Image
                  Image.asset(
                    state.backgroundImage,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  // Game Title
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 24, right: 24),
                    child: TitleWidget(
                        title: 'ابحث عن حرف ال ${state.currentCharacter}'),
                  ),

                  // Counter Display
                  Positioned(
                    top: 150,
                    left: 24,
                    right: 24,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: kLightWhiteColor,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'المتبقي : ${state.remainingCharacters}',
                                  style: Styles.textStyle20.copyWith(
                                      color: kLightBlackColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          horizontalSpace(30),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<FindCharacterCubit>()
                                  .resetCharactersPositions(context);
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: kLightWhiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            icon: const Icon(
                              Icons.refresh,
                              color: kLightBlackColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Characters positioned randomly
                  ...state.characterPositions.map(
                    (position) {
                      if (!position.isVisible) {
                        return const SizedBox.shrink();
                      }

                      return Positioned(
                        left: position.left,
                        top: position.top,
                        child: GestureDetector(
                          onTap: () => context
                              .read<FindCharacterCubit>()
                              .onCharacterTapped(context, position.id),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              state.currentCharacter,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }

          // Default fallback
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
