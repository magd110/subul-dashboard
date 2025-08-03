import 'package:equatable/equatable.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/data/models/parcel_model.dart';

sealed class AddParcelState extends Equatable {
  const AddParcelState();

  @override
  List<Object?> get props => [];
}

final class AddParcelInitial extends AddParcelState {}

final class AddParcelLoading extends AddParcelState {}

final class AddParcelSuccess extends AddParcelState {
  final ParcelModel parcel;

  const AddParcelSuccess(this.parcel);

  @override
  List<Object?> get props => [parcel];
}

final class AddParcelFailure extends AddParcelState {
  final String errorMessage;

  const AddParcelFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}