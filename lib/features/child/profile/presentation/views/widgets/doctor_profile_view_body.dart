import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/di/dependency_injection.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/profile/presentation/cubits/doctor_profile_cubit/doctor_profile_cubit.dart';
import 'package:yosrixia/features/widgets/user_avatar.dart';

class DoctorProfileViewBody extends StatelessWidget {
  const DoctorProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorProfileCubit(firebaseInstance: getIt())..getDoctorProfile(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: kBlueColor,
                size: 28,
              ),
            ),
            title: Text(
              'الصفحة الشخصية',
              style: Styles.textStyle40,
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
            builder: (context, state) {
              if (state is DoctorProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kBlueColor,
                  ),
                );
              } else if (state is DoctorProfileLoaded) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Doctor Avatar
                      UserAvatar(
                        role: 'doctor',
                        imageUrl: state.doctorModel.imageUrl,
                      ),

                      const SizedBox(height: 24),

                      // Doctor Name
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues( alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'د/ ${state.doctorModel.name}',
                              style: Styles.textStyle40,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Contact Information Section
                      _buildInfoCard(
                        icon: Icons.email,
                        title: 'البريد الإلكتروني',
                        content: state.doctorModel.email,
                      ),

                      const SizedBox(height: 16),

                      _buildInfoCard(
                        icon: Icons.phone,
                        title: 'رقم الهاتف',
                        content: state.doctorModel.number,
                      ),

                      const SizedBox(height: 32),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionButton(
                              context: context,
                              label: 'تعديل الملف الشخصي',
                              icon: Icons.edit,
                              onPressed: () {
                                // Navigate to edit profile page
                                _showEditDialog(context, state.doctorModel);
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                );
              } else if (state is DoctorProfileFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 60,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'حدث خطأ',
                        style: Styles.textStyle32,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          state.error,
                          style: Styles.textStyle18,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          context.read<DoctorProfileCubit>().getDoctorProfile();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBlueColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          'إعادة المحاولة',
                          style: Styles.textStyle20,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text('حدث خطأ ما'),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues( alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kBlueColor.withValues( alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 28,
              color: kBlueColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Styles.textStyle18.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: Styles.textStyle24,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24),
      label: Text(
        label,
        style: Styles.textStyle24,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: kBlueColor,
        foregroundColor: kPrimaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
      ),
    );
  }

  void _showEditDialog(BuildContext context, dynamic doctorModel) {
    final nameController = TextEditingController(text: doctorModel.name);
    final phoneController = TextEditingController(text: doctorModel.number);

    showDialog(
      context: context,
      builder: (dialogContext) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'تعديل الملف الشخصي',
            style: Styles.textStyle32.copyWith(color: kBlackColor),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'الاسم',
                    labelStyle: Styles.textStyle20,
                    prefixIcon: const Icon(Icons.person, color: kBlueColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: kBlueColor, width: 2),
                    ),
                  ),
                  style: Styles.textStyle20,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'رقم الهاتف',
                    labelStyle: Styles.textStyle20,
                    prefixIcon: const Icon(Icons.phone, color: kBlueColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: kBlueColor, width: 2),
                    ),
                  ),
                  style: Styles.textStyle20,
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'إلغاء',
                style: Styles.textStyle20.copyWith(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<DoctorProfileCubit>().updateDoctorProfile(
                      name: nameController.text,
                      number: phoneController.text,
                    );
                Navigator.of(dialogContext).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kBlueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'حفظ',
                style: Styles.textStyle20.copyWith(color: kPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
