import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/assets_data.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import '../cubit/chat_cubit.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_input.dart';
import 'widgets/typing_indicator.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: const ChatViewContent(),
    );
  }
}

class ChatViewContent extends StatelessWidget {
  const ChatViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 20,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: kPrimaryColor,
            size: 28,
          ),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text(
          'صحابى',
          style: Styles.textStyle32.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundColor: kPrimaryColor,
            child: Image.asset(
              AssetsData.chat,
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatInitial) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: 80,
                          color: kPrimaryColor.withValues(alpha:0.7),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'مرحباً بك في المحادثة!',
                          style: Styles.textStyle24.copyWith(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'ابدأ محادثة جديدة بكتابة رسالة',
                          style: Styles.textStyle18.copyWith(
                            color: kPrimaryColor.withValues(alpha:0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                } else if (state is ChatLoaded) {
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message =
                          state.messages[state.messages.length - 1 - index];
                      return ChatBubble(message: message);
                    },
                  );
                } else if (state is ChatTyping) {
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: state.messages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const TypingIndicator();
                      }
                      final message =
                          state.messages[state.messages.length - index];
                      return ChatBubble(message: message);
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
                          color: Colors.red.withValues(alpha:0.7),
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
                            color: kPrimaryColor.withValues(alpha:0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          const ChatInput(),
        ],
      ),
    );
  }
}
