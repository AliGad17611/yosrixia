import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

/// Theme configuration for chat bubbles
class ChatBubbleTheme {
  static const double bubbleMaxWidth = 0.7;
  static const double avatarSize = 40.0;
  static const double borderRadius = 20.0;
  static const double smallBorderRadius = 4.0;

  static const EdgeInsets bubbleMargin =
      EdgeInsets.symmetric(vertical: 8, horizontal: 16);
  static const EdgeInsets bubblePadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  static const EdgeInsets senderNamePadding =
      EdgeInsets.only(bottom: 4, right: 8, left: 8);

  // User message styling
  static Color get userBubbleColor => kSecondaryColor.withValues(alpha: 0.5);
  static Color get userTextColor => kPrimaryColor;
  static Color get userTimeColor => kPrimaryColor.withValues(alpha: 0.7);
  static Color get userAvatarColor => kBlueColor;

  // Other user message styling
  static Color get otherBubbleColor => kPrimaryColor;
  static Color get otherTextColor => kSecondaryColor;
  static Color get otherTimeColor => kSecondaryColor.withValues(alpha: 0.6);
  static Color get otherAvatarColor => kPurpleColor;

  // Status indicator colors
  static Color get sendingColor => kPrimaryColor.withValues(alpha: 0.7);
  static Color get sentColor => kPrimaryColor.withValues(alpha: 0.7);
  static Color get failedColor => Colors.red.withValues(alpha: 0.8);
  static Color get failedBackgroundColor => Colors.red.withValues(alpha: 0.1);

  // Common colors
  static Color get shadowColor => Colors.black.withValues(alpha: 0.1);
  static Color get borderColor => kPrimaryColor.withValues(alpha: 0.3);
  static Color get senderNameColor => kPrimaryColor.withValues(alpha: 0.9);

  // Text styles
  static TextStyle get messageTextStyle => Styles.textStyle18;
  static TextStyle get timeTextStyle =>
      Styles.textStyle18.copyWith(fontSize: 12);
  static TextStyle get senderNameTextStyle => Styles.textStyle18.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: senderNameColor,
      );

  // Shadow configuration
  static List<BoxShadow> get bubbleShadow => [
        BoxShadow(
          color: shadowColor,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  // Border radius configurations
  static BorderRadius getUserBubbleRadius() => const BorderRadius.only(
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
        bottomLeft: Radius.circular(smallBorderRadius),
        bottomRight: Radius.circular(borderRadius),
      );

  static BorderRadius getOtherBubbleRadius() => const BorderRadius.only(
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
        bottomLeft: Radius.circular(borderRadius),
        bottomRight: Radius.circular(smallBorderRadius),
      );
}
