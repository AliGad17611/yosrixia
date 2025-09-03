import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manger/cubit/chat_cubit.dart';
import '../../manger/models/chat_message.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/date_separator.dart';

/// Component that displays the list of chat messages with date separators
class ChatMessagesList extends StatelessWidget {
  final List<ChatMessage> messages;
  final bool isRefreshing;

  const ChatMessagesList({
    super.key,
    required this.messages,
    required this.isRefreshing,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _handleRefresh(context),
      child: _MessagesListView(messages: messages),
    );
  }

  /// Handles the pull-to-refresh functionality
  Future<void> _handleRefresh(BuildContext context) async {
    final completer = Completer<void>();

    // Listen for state changes to complete the refresh
    final subscription = context.read<ChatCubit>().stream.listen((state) {
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
    context.read<ChatCubit>().refreshMessages();

    // Wait for completion with timeout and cleanup
    try {
      await completer.future.timeout(const Duration(seconds: 10));
    } catch (e) {
      if (!completer.isCompleted) {
        completer.complete();
      }
    } finally {
      subscription.cancel();
    }
  }
}

/// Internal widget that builds the actual messages list view
class _MessagesListView extends StatelessWidget {
  final List<ChatMessage> messages;

  const _MessagesListView({required this.messages});

  @override
  Widget build(BuildContext context) {
    final items = _buildChatItems();

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final reversedIndex = items.length - 1 - index;
        final item = items[reversedIndex];

        if (item is ChatMessage) {
          return ChatBubble(message: item);
        } else if (item is DateTime) {
          return DateSeparator(date: item);
        }

        return const SizedBox.shrink();
      },
    );
  }

  /// Builds a list of chat items (messages and date separators)
  List<dynamic> _buildChatItems() {
    if (messages.isEmpty) return [];

    final List<dynamic> items = [];
    DateTime? lastDate;

    // Sort messages by timestamp (oldest first for processing)
    final sortedMessages = List<ChatMessage>.from(messages)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    for (final message in sortedMessages) {
      final messageDate = DateTime(
        message.timestamp.year,
        message.timestamp.month,
        message.timestamp.day,
      );

      // Add date separator if this is a new day
      if (lastDate == null || !_isSameDay(lastDate, messageDate)) {
        items.add(messageDate);
        lastDate = messageDate;
      }

      items.add(message);
    }

    return items;
  }

  /// Checks if two dates are on the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
