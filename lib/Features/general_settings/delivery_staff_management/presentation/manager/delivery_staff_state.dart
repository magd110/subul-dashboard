import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/data/models/delivery_staff_model.dart';

import  'delivery_staff_cubit.dart';


import 'package:equatable/equatable.dart';

sealed class DeliveryStaffState extends Equatable {
  const DeliveryStaffState();

  @override
  List<Object?> get props => [];
}

final class DeliveryStaffInitial extends DeliveryStaffState {}

final class DeliveryStaffLoading extends DeliveryStaffState {}

final class DeliveryStaffFailure extends DeliveryStaffState {
  final String errorMessage;

  const DeliveryStaffFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class DeliveryStaffSuccess extends DeliveryStaffState {
  final List<DeliveryStaffModel> staff;

  const DeliveryStaffSuccess(this.staff);

  @override
  List<Object?> get props => [staff];
}

final class DeliveryStaffCreateSuccess extends DeliveryStaffState {
  final String message;

  const DeliveryStaffCreateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
final class DeliveryStaffDeleteSuccess extends DeliveryStaffState {
  final String message;
  const DeliveryStaffDeleteSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
final class DeliveryStaffUpdateSuccess extends DeliveryStaffState {
  final String message;

  const DeliveryStaffUpdateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

