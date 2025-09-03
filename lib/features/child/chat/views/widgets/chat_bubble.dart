import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import '../../manger/models/chat_message.dart';

class ChatBubble extends StatefulWidget {
  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  Timer? _timer;
  String _timeString = '';

  @override
  void initState() {
    super.initState();
    _updateTimeString();
    _startTimer();
  }

  void _startTimer() {
    // Since we're showing actual time, we only need to update when the day changes
    // Update every hour to handle day transitions (today -> yesterday)
    _timer = Timer.periodic(const Duration(hours: 1), (_) {
      if (mounted) {
        _updateTimeString();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTimeString() {
    setState(() {
      _timeString = _formatTime(widget.message.timestamp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: widget.message.isFromUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!widget.message.isFromUser) ...[
            _buildAvatar(),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: widget.message.isFromUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!widget.message.isFromUser)
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 4, right: 8, left: 8),
                    child: Text(
                      widget.message.senderName!,
                      style: Styles.textStyle18.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor.withValues(alpha: 0.9),
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
                    color: widget.message.isFromUser
                        ? kSecondaryColor.withValues(alpha: 0.5)
                        : kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: widget.message.isFromUser
                          ? const Radius.circular(4)
                          : const Radius.circular(20),
                      bottomRight: widget.message.isFromUser
                          ? const Radius.circular(20)
                          : const Radius.circular(4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: widget.message.isFromUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.message.message,
                        style: Styles.textStyle18.copyWith(
                          color: widget.message.isFromUser
                              ? kPrimaryColor
                              : kSecondaryColor,
                        ),
                        textAlign: widget.message.isFromUser
                            ? TextAlign.right
                            : TextAlign.left,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _timeString,
                        style: Styles.textStyle18.copyWith(
                          fontSize: 12,
                          color: widget.message.isFromUser
                              ? kPrimaryColor.withValues(alpha: 0.7)
                              : kSecondaryColor.withValues(alpha: 0.6),
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
          color: kPrimaryColor.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: widget.message.senderImageUrl?.isNotEmpty ?? false
            ? (widget.message.senderImageUrl?.startsWith('assets/') ?? false)
                ? Image.asset(
                    widget.message.senderImageUrl!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    widget.message.senderImageUrl!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildDefaultAvatar();
                    },
                  )
            : _buildDefaultAvatar(),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: widget.message.isFromUser ? kBlueColor : kPurpleColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        widget.message.isFromUser ? Icons.person : Icons.smart_toy,
        color: kPrimaryColor,
        size: 24,
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final isToday = now.day == timestamp.day &&
        now.month == timestamp.month &&
        now.year == timestamp.year;

    final isYesterday =
        now.subtract(const Duration(days: 1)).day == timestamp.day &&
            now.subtract(const Duration(days: 1)).month == timestamp.month &&
            now.subtract(const Duration(days: 1)).year == timestamp.year;

    // Format time in 12-hour format
    final hour = timestamp.hour == 0
        ? 12
        : (timestamp.hour > 12 ? timestamp.hour - 12 : timestamp.hour);
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final period = timestamp.hour < 12 ? 'ص' : 'م';
    final timeString = '$hour:$minute $period';

    if (isToday) {
      return timeString;
    } else if (isYesterday) {
      return 'أمس $timeString';
    } else {
      // For older messages, show date and time
      final day = timestamp.day.toString().padLeft(2, '0');
      final month = timestamp.month.toString().padLeft(2, '0');
      return '$day/$month $timeString';
    }
  }
}
