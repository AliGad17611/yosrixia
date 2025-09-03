/// Enum to track message sending status
enum MessageStatus {
  sending, // Message is being sent
  sent, // Message sent successfully
  failed, // Message failed to send
}

class ChatMessage {
  final String id;
  final String message;
  final bool isFromUser;
  final String? senderName;
  final String? senderImageUrl;
  final DateTime timestamp;
  final MessageStatus status;

  ChatMessage({
    required this.id,
    required this.message,
    required this.isFromUser,
    this.senderName,
    this.senderImageUrl,
    required this.timestamp,
    this.status = MessageStatus.sent, // Default to sent for existing messages
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      message: json['message'],
      isFromUser: json['isFromUser'],
      senderName: json['senderName'],
      senderImageUrl: json['senderImageUrl'],
      timestamp: DateTime.parse(json['timestamp']),
      status: MessageStatus.sent, // Messages from server are always sent
    );
  }

  /// Create a copy of this message with updated fields
  ChatMessage copyWith({
    String? id,
    String? message,
    bool? isFromUser,
    String? senderName,
    String? senderImageUrl,
    DateTime? timestamp,
    MessageStatus? status,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      message: message ?? this.message,
      isFromUser: isFromUser ?? this.isFromUser,
      senderName: senderName ?? this.senderName,
      senderImageUrl: senderImageUrl ?? this.senderImageUrl,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
    );
  }

  /// Create a pending message (for immediate UI display)
  static ChatMessage createPending({
    required String message,
    required bool isFromUser,
    String? senderName,
    String? senderImageUrl,
  }) {
    return ChatMessage(
      id: 'pending_${DateTime.now().millisecondsSinceEpoch}',
      message: message,
      isFromUser: isFromUser,
      senderName: senderName,
      senderImageUrl: senderImageUrl,
      timestamp: DateTime.now(),
      status: MessageStatus.sending,
    );
  }
}
