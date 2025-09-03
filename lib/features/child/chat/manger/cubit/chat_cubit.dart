import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/chat_message.dart';
import '../services/chat_user_service.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatInitial()) {
    _initialize();
  }

  final ChatUserService _chatUserService = ChatUserService();
  StreamSubscription<List<ChatMessage>>? _messagesSubscription;

  /// Track if cubit is closed to prevent emissions after close
  bool _isClosed = false;

  /// Track pending messages to avoid duplicates
  final Set<String> _pendingMessages = <String>{};

  /// Store pending message objects for UI display
  final List<ChatMessage> _pendingMessageObjects = <ChatMessage>[];

  /// Debounce timer for message updates
  Timer? _messageUpdateDebouncer;

  /// Safe emit method that checks if cubit is closed and validates state transitions
  void _safeEmit(ChatState newState) {
    if (_isClosed || isClosed) return;

    // Validate state transition
    if (_isValidStateTransition(state, newState)) {
      emit(newState);
    } else {
      debugPrint(
          'Invalid state transition from ${state.runtimeType} to ${newState.runtimeType}');
      // For invalid transitions, we might want to emit an error or ignore
      // For now, we'll allow the transition but log it
      emit(newState);
    }
  }

  /// Validate if a state transition is allowed
  bool _isValidStateTransition(ChatState currentState, ChatState newState) {
    // Define valid state transitions
    switch (currentState.runtimeType) {
      case const (ChatInitial):
        // From Initial, we can go to Loading or Error states
        return newState is ChatLoading || newState is ChatErrorState;

      case const (ChatLoading):
        // From Loading, we can go to Loaded, Initial, or Error states
        return newState is ChatLoaded ||
            newState is ChatInitial ||
            newState is ChatErrorState;

      case const (ChatLoaded):
        // From Loaded, we can go to Loading (refresh), or Error states
        return newState is ChatLoaded || // Allow updates to loaded state
            newState is ChatLoading ||
            newState is ChatErrorState;

      default:
        // From any error state, we can transition to any other state (recovery)
        if (currentState is ChatErrorState) {
          return true;
        }
        // Unknown current state, allow transition
        return true;
    }
  }

  /// Initialize the chat system
  Future<void> _initialize() async {
    try {
      _safeEmit(const ChatLoading());
      await _chatUserService.openBox();
      await _startListeningToMessages();
    } catch (e) {
      _handleInitializationError(e);
    }
  }

  /// Handle initialization errors with proper error categorization
  void _handleInitializationError(dynamic error) {
    String errorMessage;
    String? errorCode;

    if (error is SocketException) {
      errorMessage =
          'لا يوجد اتصال بالإنترنت. يرجى التحقق من الاتصال والمحاولة مرة أخرى.';
      _safeEmit(ChatNetworkError(message: errorMessage));
      return;
    } else if (error.toString().contains('permission')) {
      errorMessage = 'لا توجد صلاحيات كافية للوصول إلى المحادثة.';
      _safeEmit(ChatPermissionError(message: errorMessage));
      return;
    } else {
      errorMessage = 'فشل في تهيئة المحادثة: ${error.toString()}';
      errorCode = 'INITIALIZATION_ERROR';
    }

    _safeEmit(ChatInitializationError(
      message: errorMessage,
      errorCode: errorCode,
    ));
  }

  /// Start listening to messages stream
  Future<void> _startListeningToMessages() async {
    try {
      // Cancel previous subscription if exists
      await _messagesSubscription?.cancel();

      _messagesSubscription = _chatUserService.getMessages().listen(
            _handleMessagesUpdate,
            onError: _handleMessagesError,
            cancelOnError: false,
          );
    } catch (e) {
      _handleMessagesError(e);
    }
  }

  /// Handle messages stream updates with debouncing
  void _handleMessagesUpdate(List<ChatMessage> messages) {
    // Cancel previous debounce timer
    _messageUpdateDebouncer?.cancel();

    // Debounce message updates to avoid excessive UI updates
    _messageUpdateDebouncer = Timer(const Duration(milliseconds: 100), () {
      if (_isClosed) return;

      if (messages.isEmpty && _pendingMessageObjects.isEmpty) {
        _safeEmit(const ChatInitial());
      } else {
        // Create a new list to avoid mutation issues
        final messagesList = List<ChatMessage>.from(messages);

        // Update pending messages status based on server messages
        _updatePendingMessagesStatus(messagesList);

        // Create a copy of pending messages to avoid mutation
        final pendingMessagesList =
            List<ChatMessage>.from(_pendingMessageObjects);

        _safeEmit(ChatLoaded(
          messages: messagesList,
          pendingMessages: pendingMessagesList,
        ));
      }
    });
  }

  /// Update pending messages status based on server messages
  void _updatePendingMessagesStatus(List<ChatMessage> serverMessages) {
    // Remove pending messages that are now confirmed on server
    _pendingMessageObjects.removeWhere((pendingMsg) {
      final existsOnServer = serverMessages.any((serverMsg) =>
          serverMsg.message == pendingMsg.message &&
          serverMsg.isFromUser == pendingMsg.isFromUser &&
          serverMsg.timestamp.difference(pendingMsg.timestamp).inSeconds.abs() <
              60);

      if (existsOnServer) {
        _pendingMessages.remove(pendingMsg.message);
        return true;
      }
      return false;
    });
  }

  /// Mark a message as failed
  void _markMessageAsFailed(String messageId) {
    for (int i = 0; i < _pendingMessageObjects.length; i++) {
      if (_pendingMessageObjects[i].id == messageId) {
        _pendingMessageObjects[i] = _pendingMessageObjects[i].copyWith(
          status: MessageStatus.failed,
        );
        break;
      }
    }
  }

  /// Retry sending a failed message
  Future<void> retryMessage(String messageId) async {
    final messageIndex =
        _pendingMessageObjects.indexWhere((msg) => msg.id == messageId);
    if (messageIndex == -1) return;

    final message = _pendingMessageObjects[messageIndex];
    if (message.status != MessageStatus.failed) return;

    // Update message status to sending
    _pendingMessageObjects[messageIndex] =
        message.copyWith(status: MessageStatus.sending);

    // Update UI
    final currentState = state;
    if (currentState is ChatLoaded) {
      _safeEmit(currentState.copyWith(
        pendingMessages: List<ChatMessage>.from(_pendingMessageObjects),
      ));
    }

    try {
      // Retry sending the message
      await _chatUserService.sendMessage(message.message).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException(
              'Message sending timed out', const Duration(seconds: 30));
        },
      );

      // Success will be handled by the stream listener
    } catch (e) {
      // Mark as failed again
      _markMessageAsFailed(messageId);

      // Update UI
      if (currentState is ChatLoaded) {
        _safeEmit(currentState.copyWith(
          pendingMessages: List<ChatMessage>.from(_pendingMessageObjects),
        ));
      }
    }
  }

  /// Handle messages stream errors
  void _handleMessagesError(dynamic error) {
    final currentState = state;
    List<ChatMessage>? previousMessages;

    // Preserve previous messages if available
    if (currentState is ChatLoaded) {
      previousMessages = currentState.messages;
    }

    String errorMessage;
    if (error is SocketException) {
      errorMessage = 'انقطع الاتصال بالإنترنت. يرجى التحقق من الاتصال.';
      _safeEmit(ChatNetworkError(
        message: errorMessage,
        previousMessages: previousMessages,
      ));
    } else {
      errorMessage = 'فشل في تحميل الرسائل: ${error.toString()}';
      _safeEmit(ChatLoadingError(
        message: errorMessage,
        previousMessages: previousMessages,
      ));
    }
  }

  /// Send a message with optimizations
  Future<void> sendMessage(String messageText) async {
    if (messageText.trim().isEmpty) return;

    final trimmedMessage = messageText.trim();

    // Check if we're already sending this message to avoid duplicates
    if (_pendingMessages.contains(trimmedMessage)) {
      return;
    }

    // Add to pending messages
    _pendingMessages.add(trimmedMessage);

    final currentState = state;

    // Get current messages list
    List<ChatMessage> currentMessages = [];
    List<ChatMessage> currentPendingMessages = [];

    if (currentState is ChatLoaded) {
      currentMessages = List<ChatMessage>.from(currentState.messages);
      currentPendingMessages =
          List<ChatMessage>.from(currentState.pendingMessages);
    }

    // Create pending message for immediate UI display
    final pendingMessage = ChatMessage.createPending(
      message: trimmedMessage,
      isFromUser: true,
      senderName: 'أنت', // Current user name
    );

    // Add to pending messages list
    _pendingMessageObjects.add(pendingMessage);
    currentPendingMessages.add(pendingMessage);

    try {
      // Immediately show the message in UI
      _safeEmit(ChatLoaded(
        messages: currentMessages,
        pendingMessages: currentPendingMessages,
      ));

      // Send message to service with timeout
      await _chatUserService.sendMessage(trimmedMessage).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException(
              'Message sending timed out', const Duration(seconds: 30));
        },
      );

      // The stream listener will automatically update with the new message
      // and remove from pending messages when it appears in the stream
    } catch (e) {
      // Mark message as failed instead of removing it
      _markMessageAsFailed(pendingMessage.id);
      _pendingMessages.remove(trimmedMessage);

      // Update UI to show failed message
      final updatedPendingMessages = _pendingMessageObjects.map((msg) {
        if (msg.id == pendingMessage.id) {
          return msg.copyWith(status: MessageStatus.failed);
        }
        return msg;
      }).toList();

      _safeEmit(ChatLoaded(
        messages: currentMessages,
        pendingMessages: updatedPendingMessages,
      ));
    }
  }

  /// Refresh messages (reload from server)
  Future<void> refreshMessages() async {
    final currentState = state;

    // If we have loaded messages, show refresh indicator
    if (currentState is ChatLoaded) {
      _safeEmit(currentState.copyWith(isRefreshing: true));
    } else {
      _safeEmit(const ChatLoading());
    }

    try {
      await _startListeningToMessages();
    } catch (e) {
      _handleMessagesError(e);
    }
  }

  /// Retry failed action based on current error state
  Future<void> retryFailedAction() async {
    final currentState = state;

    if (currentState is ChatSendingError) {
      // Retry sending the failed message
      await sendMessage(currentState.failedMessage);
    } else if (currentState is ChatErrorState) {
      // Retry loading messages
      await refreshMessages();
    } else {
      // General retry - refresh messages
      await refreshMessages();
    }
  }

  /// Clear error state and return to previous state if possible
  void clearError() {
    final currentState = state;

    if (currentState is ChatErrorState &&
        currentState.previousMessages != null) {
      _safeEmit(ChatLoaded(messages: currentState.previousMessages!));
    } else {
      _safeEmit(const ChatInitial());
    }
  }

  @override
  Future<void> close() async {
    _isClosed = true;

    // Cancel all subscriptions and timers
    await _messagesSubscription?.cancel();
    _messageUpdateDebouncer?.cancel();

    // Clear pending messages
    _pendingMessages.clear();
    _pendingMessageObjects.clear();

    return super.close();
  }
}
