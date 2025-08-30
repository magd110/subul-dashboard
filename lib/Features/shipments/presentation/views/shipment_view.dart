import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/shipments/presentation/manager/shipment_cubit.dart';
import 'package:subul_dashboard2/Features/shipments/presentation/views/widgets/shipment_body.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';



class ShipmentView extends StatefulWidget {
  const ShipmentView({super.key});

  @override
  State<ShipmentView> createState() => _ShipmentViewState();
}

class _ShipmentViewState extends State<ShipmentView>
    with AutomaticKeepAliveClientMixin {

  late final ShipmentCubit _shipmentCubit;

  @override
  void initState() {
    super.initState();
    _shipmentCubit = getIt<ShipmentCubit>()..fetchShipments();
  }

  @override
  void dispose() {
    _shipmentCubit.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // مهم للحفاظ على الحالة
    return BlocProvider.value(
      value: _shipmentCubit,
      child: const ShipmentBody(),
    );
  }
}


