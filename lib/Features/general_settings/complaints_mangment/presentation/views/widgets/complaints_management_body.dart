import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/models/complaint_model.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/presentation/manager/complaints_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/presentation/manager/complaints_state.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/presentation/views/widgets/complaint_item.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';

class ComplaintsManagementBody extends StatelessWidget {
  const ComplaintsManagementBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintsCubit, ComplaintsState>(
      builder: (context, state) {
        if (state is ComplaintsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ComplaintsSuccess) {
          final complaints = state.complaints;
    
          return Container(
            width: AppSizes.widthRatio(context, 917),
            height: AppSizes.heightRatio(context, 573),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.softGray,
                  AppColors.white,
                ],
              ),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<ComplaintsCubit>().fetchComplaints();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: complaints.length,
                itemBuilder: (context, index) {
                  final complaint = complaints[index];
                  return Column(
                    children: [
                      ComplaintItem(
                        complaint: complaint,
                        
                      ),
                      const SizedBox(height: 12),
                    ],
                  );
                },
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
