import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/presentation/manager/fixed_cost_cubit.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/presentation/views/widgets/fixed_cost_management_body.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart' show getIt;

class FixedCostManagementView extends StatefulWidget {
  const FixedCostManagementView({super.key});

  @override
  State<FixedCostManagementView> createState() =>
      _FixedCostManagementViewState();
}

class _FixedCostManagementViewState extends State<FixedCostManagementView>
    with AutomaticKeepAliveClientMixin {

  late final FixedCostCubit _fixedCostCubit;

  @override
  void initState() {
    super.initState();
    _fixedCostCubit = getIt<FixedCostCubit>()..fetchFixedCosts();
  }

  @override
  void dispose() {
    _fixedCostCubit.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // مهم للحفاظ على الحالة
    return BlocProvider.value(
      value: _fixedCostCubit,
      child: const FixedCostManagementBody(),
    );
  }
}

