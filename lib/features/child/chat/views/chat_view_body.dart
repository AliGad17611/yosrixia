import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/chat/views/widgets/chat_app_bar.dart';
import 'package:yosrixia/features/child/chat/views/widgets/chat_initial_widget.dart';
import 'package:yosrixia/features/child/chat/views/widgets/chat_loading_widget.dart';
import '../manger/cubit/chat_cubit.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_input.dart';
import 'widgets/typing_indicator.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..listenToMessages(),
      child: const ChatViewContent(),
    );
  }
}

class ChatViewContent extends StatelessWidget {
  const ChatViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChatAppBar(context),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Expanded(
              child:
                  BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
                if (state is ChatInitial) {
                  return const ChatInitialWidget();
                } else if (state is ChatLoading) {
                  return const ChatLoadingWidget();
                } else if (state is ChatLoaded) {
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(message: state.messages[state.messages.length - 1 - index]);
                    },
                  );
                } else if (state is ChatSendingLoading) {
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: state.messages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const TypingIndicator();
                      }
                      return ChatBubble(message: state.messages[state.messages.length - 1 - index]);
                    },
                  );
                } else if (state is ChatError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 80,
                          color: Colors.red.withValues(alpha: 0.7),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'حدث خطأ',
                          style: Styles.textStyle24.copyWith(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: Styles.textStyle18.copyWith(
                            color: kPrimaryColor.withValues(alpha: 0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<ChatCubit>().refreshMessages();
                          },
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('إعادة المحاولة'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ),
            const ChatInput(),
          ],
        ),
      ),
    );
  }
}
