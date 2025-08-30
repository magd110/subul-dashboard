import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/data/repos/delivery_staff_repo_impl.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/manager/delivery_staff_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/views/widgets/delivery_staff_management_body.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';

class DeliveryStaffManagementView extends StatefulWidget {
  const DeliveryStaffManagementView({super.key});

  @override
  State<DeliveryStaffManagementView> createState() =>
      _DeliveryStaffManagementViewState();
}

class _DeliveryStaffManagementViewState
    extends State<DeliveryStaffManagementView> with AutomaticKeepAliveClientMixin {

  late final DeliveryStaffCubit _deliveryStaffCubit;

  @override
  void initState() {
    super.initState();
    _deliveryStaffCubit = getIt<DeliveryStaffCubit>()..getDeliveryStaff();
  }

  @override
  void dispose() {
    _deliveryStaffCubit.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // مهم جداً للحفاظ على الحالة
    return BlocProvider.value(
      value: _deliveryStaffCubit,
      child: const DeliveryStaffManagementBody(),
    );
  }
}
