import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/data/repos/parcels_repo.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/packages_management_body.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/presentation/manager/add_parcel_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/presentation/manager/parcel_cubit.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';

class PackagesManagementView extends StatelessWidget {
  const PackagesManagementView({super.key});

 @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ParcelCubit(getIt<ParcelsRepo>())..fetchParcels(),
        ),
        BlocProvider(
          create: (_) => AddParcelCubit(getIt<ParcelsRepo>()),
        ),
      ],
      child: const PackagesManagementBody(),
    );
  }
}
