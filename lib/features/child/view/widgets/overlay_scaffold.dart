import 'package:flutter/material.dart';

class OverlayScaffold extends StatelessWidget {
  const OverlayScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.7),
      ),
    );
  }
}
