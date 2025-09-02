import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yosrixia/core/database/firebase_services.dart';
import 'package:yosrixia/features/child/chat/models/chat_message.dart';

class ChatUserService {
  var box = Hive.box('chat');

  /// send message to chat
  Future<void> sendMessage(String text) async {
    await FirebaseServices.instance.firestore.collection('chats').add({
      'senderId': FirebaseServices.instance.userId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  /// listen to chat
  Stream<List<ChatMessage>> getMessages() {
    return FirebaseServices.instance.firestore
        .collection('chats')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .asyncMap((event) async {
      final messages = await Future.wait(event.docs.map((doc) async {
        final userData = await getUserImageUrlAndName(doc['senderId']);
        return ChatMessage(
          id: doc.id,
          message: doc['text'],
          isFromUser: doc['senderId'] == FirebaseServices.instance.userId,
          senderName: userData['name'],
          senderImageUrl: userData['imageUrl'],
          timestamp: doc['timestamp'].toDate(),
        );
      }));
      return messages;
    });
  }

  /// get user imageUrl and name with userId from local storage
  Future<Map<String, dynamic>> getUserImageUrlAndName(String userId) async {
    if (box.containsKey(userId)) {
      return box.get(userId) as Map<String, dynamic>;
    } else {
      final user = await FirebaseServices.instance.getCustomUserData(userId);
      box.put(userId, {'name': user['name'], 'imageUrl': user['imageUrl']});
      return {'name': user['name'], 'imageUrl': user['imageUrl']};
    }
  }
}
