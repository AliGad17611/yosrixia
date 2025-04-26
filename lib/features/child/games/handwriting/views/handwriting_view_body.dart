import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/games/handwriting/handwriting_cubit/handwriting_cubit.dart';
import 'package:yosrixia/features/child/games/handwriting/handwriting_cubit/handwriting_state.dart';
import 'package:yosrixia/features/child/games/handwriting/helper/ink_painter.dart';

class HandwritingViewBody extends StatelessWidget {
  const HandwritingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HandwritingCubit, HandwritingState>(
        listener: (context, state) {
          if (state.error.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state.isfinished == true) {
            return const Center(
              child: Text(
                'تم الانتهاء من جميع الحروف',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            );
          }
          return Column(
            children: [
              // Drawing Canvas
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      // Background Letter
                      Center(
                        child: Text(
                          state
                              .currentLetter, // <-- Replace this with your current letter
                          style: TextStyle(
                            fontSize: 200,
                            color: Colors.white.withValues(alpha: 0.3),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Drawing Canvas
                      GestureDetector(
                        onPanStart: (details) {
                          context
                              .read<HandwritingCubit>()
                              .startNewStroke(details.localPosition);
                        },
                        onPanUpdate: (details) {
                          context
                              .read<HandwritingCubit>()
                              .addPointToStroke(details.localPosition);
                        },
                        onPanEnd: (details) {
                          context.read<HandwritingCubit>().endStroke();
                        },
                        child: CustomPaint(
                          painter: InkPainter(
                            strokes: state.strokes,
                            currentPoints: state.currentPoints,
                          ),
                          size: Size.infinite,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Buttons
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: state.isProcessing
                          ? null
                          : () => context.read<HandwritingCubit>().clearInk(),
                      child: const Text(
                        'مسح',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: state.isProcessing || !state.isModelDownloaded
                          ? null
                          : () => context.read<HandwritingCubit>().nextLetter(),
                      child: state.isProcessing
                          ? const CircularProgressIndicator()
                          : const Text('التالي'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
