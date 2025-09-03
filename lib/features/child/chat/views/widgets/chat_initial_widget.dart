import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class ChatInitialWidget extends StatelessWidget {
  const ChatInitialWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline_rounded,
            size: 80,
            color: kPrimaryColor.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 16),
          Text(
            'مرحباً بك في المحادثة!',
            style: Styles.textStyle24.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ابدأ محادثة جديدة بكتابة رسالة',
            style: Styles.textStyle18.copyWith(
              color: kPrimaryColor.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
