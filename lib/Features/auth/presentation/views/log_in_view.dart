import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:subul_dashboard2/Features/auth/presentation/views/widgets/log_in_body.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: const LogInBody(),
    );
  }
}
