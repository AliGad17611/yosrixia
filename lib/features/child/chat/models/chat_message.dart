
class ChatMessage {
  final String id;
  final String message;
  final bool isFromUser;
  final String? senderName;
  final String? senderImageUrl;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.message,
    required this.isFromUser,
    this.senderName,
    this.senderImageUrl,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      message: json['message'],
      isFromUser: json['isFromUser'],
      senderName: json['senderName'],
      senderImageUrl: json['senderImageUrl'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  
}
