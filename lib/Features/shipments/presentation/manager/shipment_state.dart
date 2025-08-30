

import 'package:equatable/equatable.dart';
import 'package:subul_dashboard2/Features/shipments/data/models/shipment_model.dart';

sealed class ShipmentState extends Equatable {
  const ShipmentState();

  @override
  List<Object?> get props => [];
}

final class ShipmentInitial extends ShipmentState {}
final class ShipmentLoading extends ShipmentState {}
final class ShipmentFailure extends ShipmentState {
  final String errorMessage;
  const ShipmentFailure(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
final class ShipmentSuccess extends ShipmentState {
  final List<ShipmentModel> shipments;
  const ShipmentSuccess(this.shipments);
  @override
  List<Object?> get props => [shipments];
}
