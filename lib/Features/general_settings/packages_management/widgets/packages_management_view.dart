import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/data/repos/parcels_repo.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/packages_management_body.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/presentation/manager/add_parcel_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/presentation/manager/parcel_cubit.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';

class PackagesManagementView extends StatefulWidget {
  const PackagesManagementView({super.key});

  @override
  State<PackagesManagementView> createState() => _PackagesManagementViewState();
}

class _PackagesManagementViewState extends State<PackagesManagementView>
    with AutomaticKeepAliveClientMixin {
  late final ParcelCubit _parcelCubit;
  late final AddParcelCubit _addParcelCubit;

  @override
  void initState() {
    super.initState();
    _parcelCubit = ParcelCubit(getIt<ParcelsRepo>())..fetchParcels();
    _addParcelCubit = AddParcelCubit(getIt<ParcelsRepo>());
  }

  @override
  void dispose() {
    _parcelCubit.close();
    _addParcelCubit.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _parcelCubit),
        BlocProvider.value(value: _addParcelCubit),
      ],
      child: const PackagesManagementBody(),
    );
  }
}
