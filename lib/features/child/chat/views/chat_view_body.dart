import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/chat/views/widgets/chat_app_bar.dart';
import '../manger/cubit/chat_cubit.dart';
import 'widgets/chat_input.dart';
import 'handlers/chat_state_handler.dart';

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

/// Main content widget for the chat view
class ChatViewContent extends StatelessWidget {
  const ChatViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChatAppBar(context),
      body: const _ChatBody(),
    );
  }
}

/// Internal widget that handles the chat body layout
class _ChatBody extends StatelessWidget {
  const _ChatBody();

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: ChatStateHandler.buildContent,
            ),
          ),
          ChatInput(),
        ],
      ),
    );
  }
}
