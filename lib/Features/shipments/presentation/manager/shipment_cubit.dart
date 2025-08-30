import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/shipments/data/repos/shipment_repo.dart';
import 'package:subul_dashboard2/Features/shipments/presentation/manager/shipment_state.dart';




class ShipmentCubit extends Cubit<ShipmentState> {
  final ShipmentRepo _repo;
  ShipmentCubit(this._repo) : super(ShipmentInitial());

  Future<void> fetchShipments({List<String>? statuses}) async {
    emit(ShipmentLoading());
    final result = await _repo.getShipments(statuses: statuses);
    result.fold(
      (failure) => emit(ShipmentFailure(failure.eerMessage)),
      (shipments) => emit(ShipmentSuccess(shipments)),
    );
  }
}
