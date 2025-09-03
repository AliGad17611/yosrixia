import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/chat_message.dart';
import '../services/chat_user_service.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial()) {
    _initialize();
  }

  final ChatUserService chatUserService = ChatUserService();
  StreamSubscription<List<ChatMessage>>? _messagesSubscription;

  void _initialize() async {
    try {
      await chatUserService.openBox();
      _startListeningToMessages();
    } catch (e) {
      emit(ChatError(message: 'Failed to initialize chat: ${e.toString()}'));
    }
  }

  void _startListeningToMessages() {
    emit(ChatLoading());

    listenToMessages();
  }

  void listenToMessages() {
    /// cancel the previous subscription to listen to messages
    _messagesSubscription?.cancel();

    /// listen to messages to update the UI
    _messagesSubscription = chatUserService.getMessages().listen(
      (messages) {
        if (messages.isEmpty) {
          emit(ChatInitial());
        } else {
          emit(ChatLoaded(messages: messages));
        }
      },
      onError: (error) {
        emit(
            ChatError(message: 'Failed to load messages: ${error.toString()}'));
      },
    );
  }

  void sendMessage(String message) async {
    try {
      //
      final currentState = state;
      if (currentState is ChatLoaded) {
        emit(ChatSendingLoading(messages: currentState.messages));
      }

      await chatUserService.sendMessage(message);

      // The real-time listener will automatically update the UI
      // No need to manually emit states here
    } catch (e) {
      emit(ChatSendingError(message: 'Failed to send message: ${e.toString()}'));
    }
  }

  void refreshMessages() {
    _startListeningToMessages();
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
