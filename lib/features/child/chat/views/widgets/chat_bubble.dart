import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import '../../models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isFromUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isFromUser) ...[
            _buildAvatar(),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: message.isFromUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!message.isFromUser)
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 4, right: 8, left: 8),
                    child: Text(
                      message.senderName,
                      style: Styles.textStyle18.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor.withValues(alpha:0.9),
                      ),
                    ),
                  ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  decoration: BoxDecoration(
                    color: message.isFromUser
                        ? kSecondaryColor.withValues(alpha: 0.5)
                        : kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: message.isFromUser
                          ? const Radius.circular(20)
                          : const Radius.circular(4),
                      bottomRight: message.isFromUser
                          ? const Radius.circular(4)
                          : const Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: message.isFromUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.message,
                        style: Styles.textStyle18.copyWith(
                          color: message.isFromUser
                              ? kPrimaryColor
                              : kSecondaryColor,
                        ),
                        textAlign: message.isFromUser
                            ? TextAlign.right
                            : TextAlign.left,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatTime(message.timestamp),
                        style: Styles.textStyle18.copyWith(
                          fontSize: 12,
                          color: message.isFromUser
                              ? kPrimaryColor.withValues(alpha:0.7)
                              : kSecondaryColor.withValues(alpha:0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // No avatar for user messages
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: kPrimaryColor.withValues(alpha:0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: message.senderImageUrl.isNotEmpty
            ? (message.senderImageUrl.startsWith('assets/')
                ? Image.asset(
                    message.senderImageUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    message.senderImageUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildDefaultAvatar();
                    },
                  ))
            : _buildDefaultAvatar(),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: message.isFromUser ? kBlueColor : kPurpleColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        message.isFromUser ? Icons.person : Icons.smart_toy,
        color: kPrimaryColor,
        size: 24,
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} د';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} س';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }
}
