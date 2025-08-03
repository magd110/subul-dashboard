import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/repos/complaints_repo_impl.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/presentation/manager/complaints_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/presentation/views/widgets/complaints_management_body.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';

class ComplaintsManagementView extends StatelessWidget {
  const ComplaintsManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ComplaintsCubit>()..fetchComplaints(),
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: const ComplaintsManagementBody()),
    );
  }
}
