import 'package:flutter/material.dart';
import 'package:yosrixia/features/auth/views/widgets/parent%20registeration/parent_email_confirmation_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class ParentEmailConfirmation extends StatelessWidget {
  const ParentEmailConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: ParentEmailConfirmationBody());
  }
}