import 'package:flutter/material.dart';
import '../../manger/models/chat_message.dart';
import 'chat_bubble_theme.dart';
import 'message_status_indicator.dart';

/// Core message bubble widget that handles the bubble content
class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final String timeString;

  const MessageBubble({
    super.key,
    required this.message,
    required this.timeString,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ChatBubbleTheme.bubblePadding,
      constraints: BoxConstraints(
        maxWidth:
            MediaQuery.of(context).size.width * ChatBubbleTheme.bubbleMaxWidth,
      ),
      decoration: _buildBubbleDecoration(),
      child: Column(
        crossAxisAlignment: message.isFromUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMessageText(),
          const SizedBox(height: 4),
          _buildBottomRow(),
        ],
      ),
    );
  }

  BoxDecoration _buildBubbleDecoration() {
    return BoxDecoration(
      color: message.isFromUser
          ? ChatBubbleTheme.userBubbleColor
          : ChatBubbleTheme.otherBubbleColor,
      borderRadius: message.isFromUser
          ? ChatBubbleTheme.getUserBubbleRadius()
          : ChatBubbleTheme.getOtherBubbleRadius(),
      boxShadow: ChatBubbleTheme.bubbleShadow,
    );
  }

  Widget _buildMessageText() {
    return Text(
      message.message,
      style: ChatBubbleTheme.messageTextStyle.copyWith(
        color: message.isFromUser
            ? ChatBubbleTheme.userTextColor
            : ChatBubbleTheme.otherTextColor,
      ),
      textAlign: message.isFromUser ? TextAlign.right : TextAlign.left,
    );
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          timeString,
          style: ChatBubbleTheme.timeTextStyle.copyWith(
            color: message.isFromUser
                ? ChatBubbleTheme.userTimeColor
                : ChatBubbleTheme.otherTimeColor,
          ),
        ),
        if (message.isFromUser) ...[
          const SizedBox(width: 4),
          MessageStatusIndicator(message: message),
        ],
      ],
    );
  }
}
