import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/chat/views/chat_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: ChatViewBody());
  }
}
