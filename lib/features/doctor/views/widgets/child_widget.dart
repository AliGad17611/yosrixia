import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/core/models/user_model.dart';
import 'package:yosrixia/core/responsive/widget_width.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/assets_data.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class ChildWidget extends StatelessWidget {
  const ChildWidget({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        uid= user.uid;
        GoRouter.of(context).push(AppRouter.childDetails);
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: widgetWidth(context: context, width: 8)),
          width: double.infinity,
          height: 98,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: kBlueColor,
                backgroundImage: user.imageUrl == ""
                    ? const AssetImage(AssetsData.child)
                    : NetworkImage(
                        user.imageUrl,
                      ),
              ),
              const SizedBox(width: 16), // Instead of Spacer
              Expanded(
                child: Text(
                  user.name,
                  style: Styles.textStyle40.copyWith(color: kBlackColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
