import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/games/find_character_game/manger/find_character_cubit/find_character_cubit.dart';
import 'package:yosrixia/features/child/games/find_character_game/manger/helper/images_list.dart';
import 'package:yosrixia/features/child/games/find_character_game/views/widgets/error_widget.dart'
    as find_character_error;
import 'package:yosrixia/features/child/games/find_character_game/views/widgets/game_content.dart';
import 'package:yosrixia/features/child/games/find_character_game/views/widgets/loading_widget.dart';
import 'package:yosrixia/features/child/games/identical_character/views/widgets/game_finished_dialog.dart';

class FindCharacterViewBody extends StatefulWidget {
  const FindCharacterViewBody({super.key});

  @override
  State<FindCharacterViewBody> createState() => _FindCharacterViewBodyState();
}

class _FindCharacterViewBodyState extends State<FindCharacterViewBody> {
  bool _imagesPrecached = false;
  double screenWidth = 0;
  double screenHeight = 0;

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

  void _showGameFinishedDialog(
      BuildContext context, double screenWidth, double screenHeight) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => GameFinishedDialog(
        onPlayAgain: () {
          Navigator.of(dialogContext).pop();
          context
              .read<FindCharacterCubit>()
              .resetGame(screenWidth, screenHeight);
        },
        onGoBack: () {
          Navigator.of(dialogContext).pop();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => FindCharacterCubit(),
      child: BlocListener<FindCharacterCubit, FindCharacterState>(
        listener: (context, state) {
          if (state is FindCharacterSuccess) {
            _showGameFinishedDialog(context, screenWidth, screenHeight);
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
                context
                    .read<FindCharacterCubit>()
                    .initializeGame(screenWidth, screenHeight);
              });
              return const LoadingWidget();
            }

            // Loading state
            if (state is FindCharacterLoading) {
              return const LoadingWidget();
            }

            // Error state
            if (state is FindCharacterError) {
              return find_character_error.ErrorWidget(
                errorMessage: state.message,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              );
            }

            // Game state
            if (state is FindCharacterGameState) {
              return GameContent(
                state: state,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              );
            }

            // Default fallback
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}
