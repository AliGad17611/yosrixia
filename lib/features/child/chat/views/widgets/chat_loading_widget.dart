import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:yosrixia/features/child/chat/manger/helper/chat_list.dart';
import 'package:yosrixia/features/child/chat/views/widgets/chat_bubble.dart';

class ChatLoadingWidget extends StatelessWidget {
  const ChatLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: 10,
        itemBuilder: (context, index) => ChatBubble(message: chatList[index]),
      ),
    );
  }
}
