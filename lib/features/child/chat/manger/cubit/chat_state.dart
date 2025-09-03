part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;

  const ChatLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}

class ChatError extends ChatState {
  final String message;

  const ChatError({required this.message});

  @override
  List<Object> get props => [message];
}

class ChatSendingLoading extends ChatState {
  final List<ChatMessage> messages;

  const ChatSendingLoading({required this.messages});

  @override
  List<Object> get props => [messages];
}

class ChatSendingError extends ChatState {
  final String message;

  const ChatSendingError({required this.message});

  @override
  List<Object> get props => [message];
}