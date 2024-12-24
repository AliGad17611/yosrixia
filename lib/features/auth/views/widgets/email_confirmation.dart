import 'package:flutter/material.dart';
import 'package:yosrixia/features/auth/views/widgets/email_confirmation_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class EmailConfirmation extends StatelessWidget {
  const EmailConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: EmailConfirmationBody());
  }
}