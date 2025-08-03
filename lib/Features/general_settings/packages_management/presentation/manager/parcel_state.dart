import 'package:equatable/equatable.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/data/models/parcel_model.dart';

sealed class ParcelState extends Equatable {
  const ParcelState();

  @override
  List<Object?> get props => [];
}

final class ParcelInitial extends ParcelState {}

final class ParcelLoading extends ParcelState {}

final class ParcelFailure extends ParcelState {
  final String errorMessage;

  const ParcelFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class ParcelSuccess extends ParcelState {
  final List<ParcelModel> parcels;

  const ParcelSuccess(this.parcels);

  @override
  List<Object?> get props => [parcels];
}
