import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/dashboard/data/repos/get_dashboard_repo_impl.dart';
import 'package:subul_dashboard2/Features/dashboard/presentation/manager/dashboard_cubit.dart';
import 'package:subul_dashboard2/Features/dashboard/presentation/views/widgets/dashboard_body.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardCubit(getIt.get<GetDashboardRepoImpl>())..fetchDashboardStatistics(),
      child: const DashboardBody(),
    );
  }
}
