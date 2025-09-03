import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/assets_data.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

AppBar buildChatAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 20,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: kPrimaryColor,
          size: 28,
        ),
        onPressed: () => GoRouter.of(context).pop(),
      ),
      title: Text(
        'صحابى',
        style: Styles.textStyle32.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        CircleAvatar(
          backgroundColor: kPrimaryColor,
          child: Image.asset(
            AssetsData.chat,
            width: 36,
            height: 36,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }