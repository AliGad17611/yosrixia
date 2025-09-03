import 'package:flutter/material.dart';
import '../../manger/cubit/chat_cubit.dart';
import '../widgets/chat_initial_widget.dart';
import '../widgets/chat_loading_widget.dart';
import '../components/chat_messages_list.dart';
import '../components/chat_error_display.dart';

/// Handles the display logic for different chat states
class ChatStateHandler {
  /// Builds the appropriate widget based on the current chat state
  static Widget buildContent(BuildContext context, ChatState state) {
    switch (state.runtimeType) {
      case const (ChatInitial):
        return const ChatInitialWidget();

      case const (ChatLoading):
        return const ChatLoadingWidget();

      case const (ChatLoaded):
        final loadedState = state as ChatLoaded;
        return ChatMessagesList(
          messages: loadedState.allMessages,
          isRefreshing: loadedState.isRefreshing,
        );

      case const (ChatInitializationError):
      case const (ChatLoadingError):
      case const (ChatSendingError):
      case const (ChatNetworkError):
      case const (ChatPermissionError):
        final errorState = state as ChatErrorState;
        return ChatErrorDisplay(errorState: errorState);

      default:
        return _buildUnknownState();
    }
  }

  /// Builds a fallback widget for unknown states
  static Widget _buildUnknownState() {
    return const Center(
      child: Text(
        'حالة غير معروفة',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}
