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
      appBar: AppBar(
        title: const Text('Handwriting to Text'),
      ),
      body: BlocConsumer<HandwritingCubit, HandwritingState>(
        listener: (context, state) {
          if (state.error.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
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
                  child: GestureDetector(
                    onPanStart: (details) {
                      context.read<HandwritingCubit>().startNewStroke(details.localPosition);
                    },
                    onPanUpdate: (details) {
                      context.read<HandwritingCubit>().addPointToStroke(details.localPosition);
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
                ),
              ),
              
              // Recognized Text Display
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recognized Text:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.recognizedText.isEmpty ? 'Write something...' : state.recognizedText,
                      style: TextStyle(
                        fontSize: 18,
                        color: state.recognizedText.isEmpty ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Buttons
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: state.isProcessing 
                          ? null 
                          : () => context.read<HandwritingCubit>().clearInk(),
                      child: const Text('Clear'),
                    ),
                    ElevatedButton(
                      onPressed: state.isProcessing || !state.isModelDownloaded 
                          ? null 
                          : () => context.read<HandwritingCubit>().recognizeText(),
                      child: state.isProcessing
                          ? const CircularProgressIndicator()
                          : const Text('Recognize'),
                    ),
                    if (!state.isModelDownloaded)
                      ElevatedButton(
                        onPressed: state.isProcessing 
                            ? null 
                            : () => context.read<HandwritingCubit>().downloadModel(),
                        child: state.isProcessing
                            ? const CircularProgressIndicator()
                            : const Text('Download Model'),
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