import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yosrixia/core/database/firebase_services.dart';
import 'package:yosrixia/features/child/chat/manger/models/chat_message.dart';

class ChatUserService {
  late Box box;
  Future<void> openBox() async {
    box = await Hive.openBox('chat');
  }

  /// send message to chat
  Future<void> sendMessage(String text) async {
    await FirebaseServices.instance.firestore.collection('chat').add({
      'senderId': FirebaseServices.instance.userId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  /// listen to chat
  Stream<List<ChatMessage>> getMessages() {
    return FirebaseServices.instance.firestore
        .collection('chat')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .asyncMap((event) async {
      try {
        final messages = await Future.wait(event.docs.map((doc) async {
          final data = doc.data();
          final senderId = data['senderId'] as String;
          final text = data['text'] as String;
          final timestamp = data['timestamp'];

          final userData = await getUserImageUrlAndName(senderId);
          DateTime messageTimestamp;
          try {
            messageTimestamp = timestamp?.toDate() ?? DateTime.now();
          } catch (e) {
            debugPrint('Error parsing timestamp for message ${doc.id}: $e');
            messageTimestamp = DateTime.now();
          }

          return ChatMessage(
            id: doc.id,
            message: text,
            isFromUser: senderId == FirebaseServices.instance.userId,
            senderName: userData['name'] ?? 'مجهول',
            senderImageUrl: userData['imageUrl'],
            timestamp: messageTimestamp,
          );
        }));
        return messages;
      } catch (e) {
        debugPrint('Error getting messages: $e');
        return <ChatMessage>[];
      }
    });
  }

  /// get user imageUrl and name with userId from local storage
  Future<Map<String, dynamic>> getUserImageUrlAndName(String userId) async {
    if (box.containsKey(userId)) {
      return {
        'name': box.get(userId)['name'],
        'imageUrl': box.get(userId)['imageUrl']
      };
    } else {
      final user = await FirebaseServices.instance.getCustomUserData(userId);
      box.put(userId, {'name': user['name'], 'imageUrl': user['imageUrl']});
      return {'name': user['name'], 'imageUrl': user['imageUrl']};
    }
  }
}
