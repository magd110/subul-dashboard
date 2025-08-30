import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/repos/complaints_repo_impl.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/presentation/manager/complaints_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/presentation/views/widgets/complaints_management_body.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';

class ComplaintsManagementView extends StatefulWidget {
  const ComplaintsManagementView({super.key});

  @override
  State<ComplaintsManagementView> createState() =>
      _ComplaintsManagementViewState();
}

class _ComplaintsManagementViewState extends State<ComplaintsManagementView>
    with AutomaticKeepAliveClientMixin {

  late final ComplaintsCubit _complaintsCubit;

  @override
  void initState() {
    super.initState();
    _complaintsCubit = getIt<ComplaintsCubit>()..fetchComplaints();
  }

  @override
  void dispose() {
    _complaintsCubit.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // مهم للحفاظ على الحالة
    return BlocProvider.value(
      value: _complaintsCubit,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: const ComplaintsManagementBody(),
      ),
    );
  }
}

