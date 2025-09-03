import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/chat/views/widgets/chat_app_bar.dart';
import 'package:yosrixia/features/child/chat/views/widgets/chat_initial_widget.dart';
import 'package:yosrixia/features/child/chat/views/widgets/chat_loading_widget.dart';
import '../manger/cubit/chat_cubit.dart';
import '../manger/models/chat_message.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_input.dart';

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
      appBar: buildChatAppBar(context),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  return _buildChatContent(context, state);
                },
              ),
            ),
            const ChatInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatContent(BuildContext context, ChatState state) {
    switch (state.runtimeType) {
      case const (ChatInitial):
        return const ChatInitialWidget();

      case const (ChatLoading):
        return const ChatLoadingWidget();

      case const (ChatLoaded):
        final loadedState = state as ChatLoaded;
        return _buildMessagesList(
            loadedState.allMessages, loadedState.isRefreshing, context);

      // ChatSendingMessage is no longer used since we show messages immediately

      case const (ChatInitializationError):
      case const (ChatLoadingError):
      case const (ChatSendingError):
      case const (ChatNetworkError):
      case const (ChatPermissionError):
        final errorState = state as ChatErrorState;
        return _buildErrorWidget(context, errorState);

      default:
        return const Center(
          child: Text(
            'حالة غير معروفة',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
    }
  }

  Widget _buildMessagesList(
      List<ChatMessage> messages, bool isRefreshing, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Use a completer to properly handle the refresh
        final completer = Completer<void>();

        // Listen for state changes to complete the refresh
        final subscription =
            BlocProvider.of<ChatCubit>(context).stream.listen((state) {
          if (state is ChatLoaded && !state.isRefreshing) {
            if (!completer.isCompleted) {
              completer.complete();
            }
          } else if (state is ChatErrorState) {
            if (!completer.isCompleted) {
              completer.complete();
            }
          }
        });

        // Trigger refresh
        BlocProvider.of<ChatCubit>(context).refreshMessages();

        // Wait for completion and cleanup
        await completer.future.timeout(
          const Duration(seconds: 10),
          onTimeout: () => completer.complete(),
        );

        subscription.cancel();
      },
      child: ListView.builder(
        reverse: true,
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final messageIndex = messages.length - 1 - index;
          return ChatBubble(message: messages[messageIndex]);
        },
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, ChatErrorState errorState) {
    IconData errorIcon;
    String errorTitle;
    Color errorColor = Colors.red;

    // Customize error display based on error type
    if (errorState is ChatNetworkError) {
      errorIcon = Icons.wifi_off_rounded;
      errorTitle = 'مشكلة في الاتصال';
      errorColor = Colors.orange;
    } else if (errorState is ChatPermissionError) {
      errorIcon = Icons.lock_outline_rounded;
      errorTitle = 'مشكلة في الصلاحيات';
      errorColor = Colors.red;
    } else if (errorState is ChatSendingError) {
      errorIcon = Icons.send_outlined;
      errorTitle = 'فشل إرسال الرسالة';
      errorColor = Colors.orange;
    } else {
      errorIcon = Icons.error_outline_rounded;
      errorTitle = 'حدث خطأ';
      errorColor = Colors.red;
    }

    return Stack(
      children: [
        // Show previous messages if available
        if (errorState.previousMessages != null &&
            errorState.previousMessages!.isNotEmpty)
          Opacity(
            opacity: 0.5,
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: errorState.previousMessages!.length,
              itemBuilder: (context, index) {
                final messageIndex =
                    errorState.previousMessages!.length - 1 - index;
                return ChatBubble(
                    message: errorState.previousMessages![messageIndex]);
              },
            ),
          ),

        // Error overlay
        Container(
          color: Colors.white.withValues(alpha: 0.9),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  errorIcon,
                  size: 80,
                  color: errorColor.withValues(alpha: 0.7),
                ),
                const SizedBox(height: 16),
                Text(
                  errorTitle,
                  style: Styles.textStyle24.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    errorState.message,
                    style: Styles.textStyle18.copyWith(
                      color: kPrimaryColor.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                _buildErrorActions(context, errorState),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorActions(BuildContext context, ChatErrorState errorState) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        // Retry button
        ElevatedButton.icon(
          onPressed: () {
            context.read<ChatCubit>().retryFailedAction();
          },
          icon: const Icon(Icons.refresh_rounded),
          label: Text(
            errorState is ChatSendingError ? 'إعادة الإرسال' : 'إعادة المحاولة',
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),

        // Clear error button (if we have previous messages)
        if (errorState.previousMessages != null &&
            errorState.previousMessages!.isNotEmpty)
          OutlinedButton.icon(
            onPressed: () {
              context.read<ChatCubit>().clearError();
            },
            icon: const Icon(Icons.close_rounded),
            label: const Text('إغلاق'),
            style: OutlinedButton.styleFrom(
              foregroundColor: kPrimaryColor,
              side: const BorderSide(color: kPrimaryColor),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
      ],
    );
  }
}
