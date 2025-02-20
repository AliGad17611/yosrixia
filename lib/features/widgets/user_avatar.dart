import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/assets_data.dart';
import 'package:yosrixia/core/utils/constants.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.imageUrl, required this.role});
  final String imageUrl;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 190,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(35),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: imageUrl == ''
            ? role == 'doctor'
                ? const Image(image: AssetImage(AssetsData.doctor))
                : const Image(image: AssetImage(AssetsData.child))
            : Image.network(
                imageUrl,
                height: 190,
                width: 190,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
