import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/data/repos/delivery_staff_repo%20.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/data/repos/delivery_staff_repo_impl.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/manager/delivery_staff_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/views/widgets/delivery_staff_management_body.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';

class DeliveryStaffManagementView extends StatelessWidget {
  const DeliveryStaffManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DeliveryStaffCubit>()..getDeliveryStaff(),
      child: DeliveryStaffManagementBody(),
    );
  }
}
