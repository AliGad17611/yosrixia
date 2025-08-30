import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/chat_message.dart';
import '../services/chat_user_service.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final List<ChatMessage> _messages = [];

  void sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Get current user info
    final userInfo = await ChatUserService.getCurrentUserInfo();

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: message,
      isFromUser: true,
      senderName: userInfo['name']!,
      senderImageUrl: userInfo['imageUrl']!,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    emit(ChatLoaded(messages: List.from(_messages)));

    // Show typing indicator
    emit(ChatTyping(messages: List.from(_messages)));

    // Simulate AI response after a short delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      _simulateAIResponse(message);
    });
  }

  void _simulateAIResponse(String userMessage) {
    String aiResponse = _generateAIResponse(userMessage);

    // Get AI info
    final aiInfo = ChatUserService.getAIInfo();

    final aiMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: aiResponse,
      isFromUser: false,
      senderName: aiInfo['name']!,
      senderImageUrl: aiInfo['imageUrl']!,
      timestamp: DateTime.now(),
    );

    _messages.add(aiMessage);
    emit(ChatLoaded(messages: List.from(_messages)));
  }

  String _generateAIResponse(String userMessage) {
    // Simple AI response simulation based on user input
    final lowerMessage = userMessage.toLowerCase();

    if (lowerMessage.contains('مرحبا') || lowerMessage.contains('السلام')) {
      return 'مرحباً بك! كيف يمكنني مساعدتك اليوم؟';
    } else if (lowerMessage.contains('كيف حالك')) {
      return 'أنا بخير، شكراً لك! كيف حالك أنت؟';
    } else if (lowerMessage.contains('تعلم') || lowerMessage.contains('درس')) {
      return 'هذا رائع! التعلم مهم جداً. هل تريد أن نبدأ بدرس جديد؟';
    } else if (lowerMessage.contains('لعبة') || lowerMessage.contains('لعب')) {
      return 'الألعاب ممتعة ومفيدة للتعلم! أي لعبة تفضل؟';
    } else if (lowerMessage.contains('مساعدة')) {
      return 'بالطبع! أنا هنا لمساعدتك. ما الذي تحتاج إلى مساعدة فيه؟';
    } else if (lowerMessage.contains('شكرا')) {
      return 'العفو! أنا سعيد لمساعدتك.';
    } else {
      return 'شكراً لك على رسالتك! هل يمكنك إخباري المزيد عن ما تريد؟';
    }
  }

  void clearChat() {
    _messages.clear();
    emit(ChatInitial());
  }
}
