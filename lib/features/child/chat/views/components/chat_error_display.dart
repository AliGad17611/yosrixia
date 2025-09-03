import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import '../../manger/cubit/chat_cubit.dart';
import '../widgets/chat_bubble.dart';

/// Component that displays error states with appropriate UI and actions
class ChatErrorDisplay extends StatelessWidget {
  final ChatErrorState errorState;

  const ChatErrorDisplay({
    super.key,
    required this.errorState,
  });

  @override
  Widget build(BuildContext context) {
    final errorConfig = _getErrorConfiguration();

    return Stack(
      children: [
        // Show previous messages if available
        if (_hasPreviousMessages()) _buildPreviousMessagesOverlay(),

        // Error overlay
        _buildErrorOverlay(context, errorConfig),
      ],
    );
  }

  /// Gets the error configuration based on error type
  _ErrorConfiguration _getErrorConfiguration() {
    if (errorState is ChatNetworkError) {
      return const _ErrorConfiguration(
        icon: Icons.wifi_off_rounded,
        title: 'مشكلة في الاتصال',
        color: Colors.orange,
      );
    } else if (errorState is ChatPermissionError) {
      return const _ErrorConfiguration(
        icon: Icons.lock_outline_rounded,
        title: 'مشكلة في الصلاحيات',
        color: Colors.red,
      );
    } else if (errorState is ChatSendingError) {
      return const _ErrorConfiguration(
        icon: Icons.send_outlined,
        title: 'فشل إرسال الرسالة',
        color: Colors.orange,
      );
    } else {
      return const _ErrorConfiguration(
        icon: Icons.error_outline_rounded,
        title: 'حدث خطأ',
        color: Colors.red,
      );
    }
  }

  /// Checks if there are previous messages to display
  bool _hasPreviousMessages() {
    return errorState.previousMessages != null &&
        errorState.previousMessages!.isNotEmpty;
  }

  /// Builds the overlay showing previous messages with reduced opacity
  Widget _buildPreviousMessagesOverlay() {
    return Opacity(
      opacity: 0.5,
      child: ListView.builder(
        reverse: true,
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: errorState.previousMessages!.length,
        itemBuilder: (context, index) {
          final messageIndex = errorState.previousMessages!.length - 1 - index;
          return ChatBubble(
            message: errorState.previousMessages![messageIndex],
          );
        },
      ),
    );
  }

  /// Builds the main error overlay with icon, message, and actions
  Widget _buildErrorOverlay(BuildContext context, _ErrorConfiguration config) {
    return Container(
      color: Colors.white.withValues(alpha: 0.9),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildErrorIcon(config),
              const SizedBox(height: 16),
              _buildErrorTitle(config),
              const SizedBox(height: 8),
              _buildErrorMessage(),
              const SizedBox(height: 24),
              _buildErrorActions(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the error icon
  Widget _buildErrorIcon(_ErrorConfiguration config) {
    return Icon(
      config.icon,
      size: 80,
      color: config.color.withValues(alpha: 0.7),
    );
  }

  /// Builds the error title
  Widget _buildErrorTitle(_ErrorConfiguration config) {
    return Text(
      config.title,
      style: Styles.textStyle24.copyWith(
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Builds the error message
  Widget _buildErrorMessage() {
    return Text(
      errorState.message,
      style: Styles.textStyle18.copyWith(
        color: kPrimaryColor.withValues(alpha: 0.8),
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Builds the error action buttons
  Widget _buildErrorActions(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        _buildRetryButton(context),
        if (_hasPreviousMessages()) _buildClearErrorButton(context),
      ],
    );
  }

  /// Builds the retry button
  Widget _buildRetryButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => context.read<ChatCubit>().retryFailedAction(),
      icon: const Icon(Icons.refresh_rounded),
      label: Text(
        errorState is ChatSendingError ? 'إعادة الإرسال' : 'إعادة المحاولة',
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }

  /// Builds the clear error button
  Widget _buildClearErrorButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => context.read<ChatCubit>().clearError(),
      icon: const Icon(Icons.close_rounded),
      label: const Text('إغلاق'),
      style: OutlinedButton.styleFrom(
        foregroundColor: kPrimaryColor,
        side: const BorderSide(color: kPrimaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}

/// Configuration class for error display
class _ErrorConfiguration {
  final IconData icon;
  final String title;
  final Color color;

  const _ErrorConfiguration({
    required this.icon,
    required this.title,
    required this.color,
  });
}
