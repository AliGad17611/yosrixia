import 'package:flutter/material.dart';
import '../../manger/models/chat_message.dart';
import 'chat_bubble_theme.dart';

/// Avatar widget for chat messages
class ChatAvatar extends StatelessWidget {
  final ChatMessage message;

  const ChatAvatar({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ChatBubbleTheme.avatarSize,
      height: ChatBubbleTheme.avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: ChatBubbleTheme.borderColor,
          width: 2,
        ),
        boxShadow: ChatBubbleTheme.bubbleShadow,
      ),
      child: ClipOval(
        child: _buildAvatarContent(),
      ),
    );
  }

  Widget _buildAvatarContent() {
    final imageUrl = message.senderImageUrl;

    if (imageUrl?.isNotEmpty ?? false) {
      if (imageUrl!.startsWith('assets/')) {
        return Image.asset(
          imageUrl,
          width: ChatBubbleTheme.avatarSize,
          height: ChatBubbleTheme.avatarSize,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(),
        );
      } else {
        return Image.network(
          imageUrl,
          width: ChatBubbleTheme.avatarSize,
          height: ChatBubbleTheme.avatarSize,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(),
        );
      }
    }

    return _buildDefaultAvatar();
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: ChatBubbleTheme.avatarSize,
      height: ChatBubbleTheme.avatarSize,
      decoration: BoxDecoration(
        color: message.isFromUser
            ? ChatBubbleTheme.userAvatarColor
            : ChatBubbleTheme.otherAvatarColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        message.isFromUser ? Icons.person : Icons.smart_toy,
        color: ChatBubbleTheme.userTextColor,
        size: 24,
      ),
    );
  }
}
