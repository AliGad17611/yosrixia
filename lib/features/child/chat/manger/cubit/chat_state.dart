part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

/// Initial state when chat is first loaded
class ChatInitial extends ChatState {
  const ChatInitial();
}

/// Loading state when initializing chat or loading messages
class ChatLoading extends ChatState {
  const ChatLoading();
}

/// State when messages are successfully loaded
class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;
  final bool isRefreshing;
  final List<ChatMessage> pendingMessages;

  const ChatLoaded({
    required this.messages,
    this.isRefreshing = false,
    this.pendingMessages = const [],
  });

  @override
  List<Object?> get props => [messages, isRefreshing, pendingMessages];

  /// Get all messages (server messages + pending messages) in chronological order
  List<ChatMessage> get allMessages {
    final combined = [...messages, ...pendingMessages];
    combined.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return combined;
  }

  ChatLoaded copyWith({
    List<ChatMessage>? messages,
    bool? isRefreshing,
    List<ChatMessage>? pendingMessages,
  }) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      pendingMessages: pendingMessages ?? this.pendingMessages,
    );
  }
}

/// Base error state
abstract class ChatErrorState extends ChatState {
  final String message;
  final String? errorCode;
  final List<ChatMessage>? previousMessages;

  const ChatErrorState({
    required this.message,
    this.errorCode,
    this.previousMessages,
  });

  @override
  List<Object?> get props => [message, errorCode, previousMessages];
}

/// Error when initializing chat
class ChatInitializationError extends ChatErrorState {
  const ChatInitializationError({
    required super.message,
    super.errorCode,
  });
}

/// Error when loading messages
class ChatLoadingError extends ChatErrorState {
  const ChatLoadingError({
    required super.message,
    super.errorCode,
    super.previousMessages,
  });
}

/// Error when sending a message
class ChatSendingError extends ChatErrorState {
  final String failedMessage;

  const ChatSendingError({
    required super.message,
    required this.failedMessage,
    super.errorCode,
    super.previousMessages,
  });

  @override
  List<Object?> get props => [...super.props, failedMessage];
}

/// Error when there's a network connectivity issue
class ChatNetworkError extends ChatErrorState {
  const ChatNetworkError({
    required super.message,
    super.previousMessages,
  }) : super(errorCode: 'NETWORK_ERROR');
}

/// Error when there's a permission issue
class ChatPermissionError extends ChatErrorState {
  const ChatPermissionError({
    required super.message,
  }) : super(errorCode: 'PERMISSION_ERROR');
}
