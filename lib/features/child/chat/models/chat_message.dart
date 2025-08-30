class ChatMessage {
  final String id;
  final String message;
  final bool isFromUser;
  final String senderName;
  final String senderImageUrl;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.message,
    required this.isFromUser,
    required this.senderName,
    required this.senderImageUrl,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      message: json['message'],
      isFromUser: json['isFromUser'],
      senderName: json['senderName'],
      senderImageUrl: json['senderImageUrl'] ?? 'https://picsum.photos/200/300',
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'isFromUser': isFromUser,
      'senderName': senderName,
      'senderImageUrl': senderImageUrl,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
