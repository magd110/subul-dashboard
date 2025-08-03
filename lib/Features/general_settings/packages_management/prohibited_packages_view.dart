import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/presentation/manager/add_parcel_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/presentation/manager/parcel_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/presentation/manager/parcel_state.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/widgets/add_parcel_dialog.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/widgets/package_items.dart';
import 'package:subul_dashboard2/core/utils/assets.dart';

class ProhibitedPackagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParcelCubit, ParcelState>(
      builder: (context, state) {
        if (state is ParcelLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ParcelFailure) {
          return Center(child: Text('خطأ: ${state.errorMessage}'));
        } else if (state is ParcelSuccess) {
          final allowedItems =
              state.parcels.where((item) => item.isAllowed == 0).toList();

          return RefreshIndicator(
            onRefresh: () => context.read<ParcelCubit>().fetchParcels(),
            child: PackageItems(
              title: "محتوى الطرود الممنوع",
              items: allowedItems,
              image: AssetsData.redCircle,
              onAddPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return BlocProvider.value(
                      value: context.read<AddParcelCubit>(),
                      child: const AddParcelDialog(
                        title: "إضافة طرد ممنوع",
                        isAllowed: 0,
                      ),
                    );
                  },
                ).then((result) {
                  if (result == true) {
                    context.read<ParcelCubit>().fetchParcels();
                  }
                });
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
