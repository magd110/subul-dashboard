import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/manager/user_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/widgets/user_management_body.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';

class UserManagementView extends StatelessWidget {
  const UserManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserCubit>(),
      child: const UserManagementBody(),
    );
  }
}
