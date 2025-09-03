import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manger/models/chat_message.dart';
import '../../manger/cubit/chat_cubit.dart';
import 'chat_bubble_theme.dart';

/// Status indicator widget for message sending status
class MessageStatusIndicator extends StatelessWidget {
  final ChatMessage message;

  const MessageStatusIndicator({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    switch (message.status) {
      case MessageStatus.sending:
        return _buildSendingIndicator();
      case MessageStatus.sent:
        return _buildSentIndicator();
      case MessageStatus.failed:
        return _buildFailedIndicator(context);
    }
  }

  Widget _buildSendingIndicator() {
    return SizedBox(
      width: 12,
      height: 12,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        valueColor: AlwaysStoppedAnimation<Color>(
          ChatBubbleTheme.sendingColor,
        ),
      ),
    );
  }

  Widget _buildSentIndicator() {
    return Icon(
      Icons.check,
      size: 14,
      color: ChatBubbleTheme.sentColor,
    );
  }

  Widget _buildFailedIndicator(BuildContext context) {
    return GestureDetector(
      onTap: () => _retryMessage(context),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: ChatBubbleTheme.failedBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.refresh,
          size: 12,
          color: ChatBubbleTheme.failedColor,
        ),
      ),
    );
  }

  void _retryMessage(BuildContext context) {
    context.read<ChatCubit>().retryMessage(message.id);
  }
}
