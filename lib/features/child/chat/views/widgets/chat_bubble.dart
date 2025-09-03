import 'dart:async';
import 'package:flutter/material.dart';
import '../../manger/models/chat_message.dart';
import 'chat_avatar.dart';
import 'message_bubble.dart';
import 'chat_bubble_theme.dart';
import '../../utils/time_formatter.dart';

/// Refactored ChatBubble widget with improved performance and modularity
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
    _startTimerIfNeeded();
  }

  @override
  void didUpdateWidget(ChatBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.message.timestamp != widget.message.timestamp) {
      _updateTimeString();
      _startTimerIfNeeded();
    }
  }

  void _startTimerIfNeeded() {
    _timer?.cancel();

    // Only start timer if the timestamp might need updating
    if (TimeFormatter.shouldUpdateTime(widget.message.timestamp)) {
      _timer = Timer.periodic(const Duration(hours: 1), (_) {
        if (mounted) {
          _updateTimeString();
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTimeString() {
    final newTimeString =
        TimeFormatter.formatMessageTime(widget.message.timestamp);
    if (_timeString != newTimeString) {
      setState(() {
        _timeString = newTimeString;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: _buildSemanticLabel(),
      child: Container(
        margin: ChatBubbleTheme.bubbleMargin,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: widget.message.isFromUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!widget.message.isFromUser) ...[
              ChatAvatar(message: widget.message),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Column(
                crossAxisAlignment: widget.message.isFromUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!widget.message.isFromUser &&
                      widget.message.senderName != null)
                    _buildSenderName(),
                  MessageBubble(
                    message: widget.message,
                    timeString: _timeString,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSenderName() {
    return Padding(
      padding: ChatBubbleTheme.senderNamePadding,
      child: Text(
        widget.message.senderName!,
        style: ChatBubbleTheme.senderNameTextStyle,
      ),
    );
  }

/// build semantic label to make the widget more accessible for screen readers 
  String _buildSemanticLabel() {
    final sender = widget.message.isFromUser
        ? 'أنت'
        : widget.message.senderName ?? 'مجهول';
    final status = _getStatusLabel();
    return 'رسالة من $sender: ${widget.message.message}. الوقت: $_timeString. $status';
  }
/// get status label to make the semantic label more accurate appear in the screen reader 
  String _getStatusLabel() {
    switch (widget.message.status) {
      case MessageStatus.sending:
        return 'جاري الإرسال';
      case MessageStatus.sent:
        return 'تم الإرسال';
      case MessageStatus.failed:
        return 'فشل الإرسال، انقر لإعادة المحاولة';
    }
  }
}
