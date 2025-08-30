import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/manager/user_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/views/widgets/user_management_body.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';

class UserManagementView extends StatefulWidget {
  const UserManagementView({super.key});

  @override
  State<UserManagementView> createState() => _UserManagementViewState();
}

class _UserManagementViewState extends State<UserManagementView>
    with AutomaticKeepAliveClientMixin {
  late final UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    _userCubit = getIt<UserCubit>();
  }

  @override
  void dispose() {
    _userCubit.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: _userCubit,
      child: const UserManagementBody(),
    );
  }
}
