import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/cubit/users_cubit.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class DoctorHeaderWidget extends StatefulWidget {
  const DoctorHeaderWidget({super.key});

  @override
  State<DoctorHeaderWidget> createState() => _DoctorHeaderWidgetState();
}

class _DoctorHeaderWidgetState extends State<DoctorHeaderWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Navigation Icons Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Personal Profile Icon
            IconButton(
              onPressed: () {
                // Navigate to settings which contains profile options
                GoRouter.of(context).push(AppRouter.settings);
              },
              icon: const Icon(
                Icons.account_circle,
                size: 30,
                color: kBlueColor,
              ),
              tooltip: 'الصفحة الشخصية',
            ),

            // Title
            Text(
              'الاطفال',
              style: Styles.textStyle96,
            ),

            // Appointment Scheduling Icon
            IconButton(
              onPressed: () {
                // Navigate to appointment scheduling
                GoRouter.of(context).push(AppRouter.appointment);
              },
              icon: const Icon(
                Icons.calendar_today,
                size: 30,
                color: kBlueColor,
              ),
              tooltip: 'تحديد ميعاد',
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Search Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              controller: _searchController,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'البحث عن طفل...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: kBlueColor),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                          });
                          context.read<UsersCubit>().searchUsers('');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onChanged: (query) {
                setState(() {}); // Rebuild to show/hide clear button
                // Search users using the cubit
                context.read<UsersCubit>().searchUsers(query);
              },
            ),
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
