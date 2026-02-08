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
      create: (context) =>
          DoctorProfileCubit(profileRepo: getIt())..getDoctorProfile(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => GoRouter.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kBlackColor,
              size: 24,
            ),
          ),
          title: Text(
            'الصفحة الشخصية',
            style: Styles.textStyle32.copyWith(
              color: kBlackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
          builder: (context, state) {
            if (state is DoctorProfileLoading) {
              return const _LoadingWidget();
            } else if (state is DoctorProfileLoaded) {
              return _DoctorProfileContent(doctor: state.doctorProfileModel);
            } else if (state is DoctorProfileFailure) {
              return _ErrorWidget(failure: state.failure);
            }
            return const Center(child: Text('حدث خطأ ما'));
          },
        ),
      ),
    );
  }
}

// Loading Widget
class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: kBlackColor,
        strokeWidth: 3,
      ),
    );
  }
}

// Main Profile Content
class _DoctorProfileContent extends StatelessWidget {
  final dynamic doctor;

  const _DoctorProfileContent({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),

            // Avatar
            UserAvatar(
              role: 'doctor',
              imageUrl: doctor.imageUrl,
            ),

            const SizedBox(height: 20),

            // Doctor Name
            _DoctorNameCard(name: doctor.name),

            const SizedBox(height: 28),

            // Contact Information
            const _SectionTitle(title: 'معلومات التواصل'),

            const SizedBox(height: 12),

            _ProfileInfoTile(
              icon: Icons.email_outlined,
              label: 'البريد الإلكتروني',
              value: doctor.email,
            ),

            const SizedBox(height: 12),

            _ProfileInfoTile(
              icon: Icons.phone_outlined,
              label: 'رقم الهاتف',
              value: doctor.number,
            ),

            const SizedBox(height: 12),

            _ProfileInfoTile(
              icon: Icons.cake_outlined,
              label: 'تاريخ الميلاد',
              value: doctor.birthDate,
            ),

            const SizedBox(height: 28),

            // Professional Information
            const _SectionTitle(title: 'المعلومات المهنية'),

            const SizedBox(height: 12),

            _ProfileInfoTile(
              icon: Icons.business_outlined,
              label: 'المؤسسة',
              value: doctor.organization,
            ),

            const SizedBox(height: 12),

            _ProfileInfoTile(
              icon: Icons.work_history_outlined,
              label: 'الخبرة',
              value: doctor.experience,
            ),

            const SizedBox(height: 32),

            // Edit Button
            _EditProfileButton(doctor: doctor),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// Doctor Name Card Widget
class _DoctorNameCard extends StatelessWidget {
  final String name;

  const _DoctorNameCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      'د/ $name',
      style: Styles.textStyle32.copyWith(
        color: kBlackColor,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }
}

// Section Title Widget
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: Styles.textStyle24.copyWith(
          fontWeight: FontWeight.w600,
          color: kBlackColor,
        ),
      ),
    );
  }
}

// Profile Info Tile Widget
class _ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileInfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kBlueColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: kBlueColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Styles.textStyle18.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Styles.textStyle20.copyWith(
                    color: kBlackColor,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Edit Profile Button Widget
class _EditProfileButton extends StatelessWidget {
  final dynamic doctor;

  const _EditProfileButton({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _showEditDialog(context, doctor),
        style: ElevatedButton.styleFrom(
          backgroundColor: kBlueColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.edit_outlined, size: 22),
            const SizedBox(width: 8),
            Text(
              'تعديل الملف الشخصي',
              style: Styles.textStyle20.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, dynamic doctorModel) {
    final nameController = TextEditingController(text: doctorModel.name);
    final phoneController = TextEditingController(text: doctorModel.number);
    final organizationController =
        TextEditingController(text: doctorModel.organization);
    final experienceController =
        TextEditingController(text: doctorModel.experience);

    // Parse birthDate string to DateTime
    DateTime selectedDate;
    try {
      selectedDate = DateTime.parse(doctorModel.birthDate);
    } catch (e) {
      // If parsing fails, use current date
      selectedDate = DateTime.now();
    }

    // Get the cubit reference before showing dialog
    final cubit = context.read<DoctorProfileCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) => _EditProfileDialog(
        nameController: nameController,
        phoneController: phoneController,
        organizationController: organizationController,
        experienceController: experienceController,
        selectedDate: selectedDate,
        onDateChanged: (date) => selectedDate = date,
        cubit: cubit,
      ),
    );
  }
}

// Edit Profile Dialog Widget
class _EditProfileDialog extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController organizationController;
  final TextEditingController experienceController;
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;
  final DoctorProfileCubit cubit;

  const _EditProfileDialog({
    required this.nameController,
    required this.phoneController,
    required this.organizationController,
    required this.experienceController,
    required this.selectedDate,
    required this.onDateChanged,
    required this.cubit,
  });

  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'تعديل الملف الشخصي',
          style: Styles.textStyle24.copyWith(
            color: kBlackColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _EditTextField(
                controller: widget.nameController,
                label: 'الاسم',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 14),
              _EditTextField(
                controller: widget.phoneController,
                label: 'رقم الهاتف',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 14),
              _DatePickerField(
                selectedDate: _selectedDate,
                onDateSelected: (date) {
                  setState(() => _selectedDate = date);
                  widget.onDateChanged(date);
                },
              ),
              const SizedBox(height: 14),
              _EditTextField(
                controller: widget.organizationController,
                label: 'المؤسسة',
                icon: Icons.business_outlined,
              ),
              const SizedBox(height: 14),
              _EditTextField(
                controller: widget.experienceController,
                label: 'الخبرة',
                icon: Icons.work_history_outlined,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'إلغاء',
              style: Styles.textStyle20.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.cubit.updateDoctorProfile(
                name: widget.nameController.text,
                number: widget.phoneController.text,
                birthDate: _selectedDate,
                organization: widget.organizationController.text,
                experience: widget.experienceController.text,
              );
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kBlueColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'حفظ',
              style: Styles.textStyle20.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Edit Text Field Widget
class _EditTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;

  const _EditTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Styles.textStyle18.copyWith(color: Colors.grey[700]),
        prefixIcon: Icon(icon, color: kBlueColor, size: 22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kBlueColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      style: Styles.textStyle18.copyWith(color: kBlackColor),
      keyboardType: keyboardType,
    );
  }
}

// Date Picker Field Widget
class _DatePickerField extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const _DatePickerField({
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1940),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: kBlueColor,
                  onPrimary: Colors.white,
                  onSurface: kBlackColor,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'تاريخ الميلاد',
          labelStyle: Styles.textStyle18.copyWith(color: Colors.grey[700]),
          prefixIcon:
              const Icon(Icons.cake_outlined, color: kBlueColor, size: 22),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        child: Text(
          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
          style: Styles.textStyle18.copyWith(color: kBlackColor),
        ),
      ),
    );
  }
}

// Error Widget
class _ErrorWidget extends StatelessWidget {
  final dynamic failure;

  const _ErrorWidget({required this.failure});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red.shade400,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'حدث خطأ',
              style: Styles.textStyle24.copyWith(
                fontWeight: FontWeight.bold,
                color: kBlackColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              failure.message,
              style: Styles.textStyle18.copyWith(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () {
                context.read<DoctorProfileCubit>().getDoctorProfile();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kBlueColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'إعادة المحاولة',
                style: Styles.textStyle20.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
