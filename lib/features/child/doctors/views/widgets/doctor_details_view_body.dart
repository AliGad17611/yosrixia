import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/doctors/cubit/doctor_details_cubit.dart';
import 'package:yosrixia/features/widgets/user_avatar.dart';
import 'package:yosrixia/features/child/doctors/views/widgets/doctor_slots_widget.dart';

class DoctorDetailsViewBody extends StatelessWidget {
  const DoctorDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorDetailsCubit()..getDoctorDetails(uid),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
            builder: (context, state) {
              if (state is DoctorDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DoctorDetailsLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Doctor Avatar and Basic Info
                      UserAvatar(
                        role: 'doctor',
                        imageUrl: state.doctorModel.imageUrl,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'د/ ${state.doctorModel.name}',
                        style: Styles.textStyle32
                            .copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      if (state.doctorModel.specialization != null &&
                          state.doctorModel.specialization!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              state.doctorModel.specialization!,
                              style: Styles.textStyle16.copyWith(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),

                      // Doctor Details Card
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              // Contact Information
                              _buildInfoRow(Icons.phone, 'رقم الهاتف',
                                  state.doctorModel.number),
                              const SizedBox(height: 16),
                              _buildInfoRow(Icons.email, 'البريد الإلكتروني',
                                  state.doctorModel.email),

                              if (state.doctorModel.organization != null &&
                                  state.doctorModel.organization!
                                      .isNotEmpty) ...[
                                const SizedBox(height: 16),
                                _buildInfoRow(Icons.business, 'المؤسسة',
                                    state.doctorModel.organization!),
                              ],

                              if (state.doctorModel.experience != null &&
                                  state.doctorModel.experience!.isNotEmpty) ...[
                                const SizedBox(height: 16),
                                _buildInfoRow(
                                    Icons.work_history,
                                    'سنوات الخبرة',
                                    state.doctorModel.experience!),
                              ],

                              if (state.doctorModel.bio != null &&
                                  state.doctorModel.bio!.isNotEmpty) ...[
                                const SizedBox(height: 16),
                                const Divider(),
                                const SizedBox(height: 8),
                                Text(
                                  'نبذة عن الطبيب',
                                  style: Styles.textStyle18
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.doctorModel.bio!,
                                  style: Styles.textStyle16.copyWith(
                                    color: Colors.grey[600],
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Available Slots Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DoctorSlotsWidget(
                          doctorId: uid,
                          doctorName: state.doctorModel.name,
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                );
              } else if (state is DoctorDetailsFailure) {
                return Center(child: Text(state.error));
              } else {
                return const Center(child: Text('Something went wrong'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Styles.textStyle14.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Styles.textStyle16.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
