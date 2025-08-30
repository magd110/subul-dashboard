import 'package:equatable/equatable.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/data/models/supplier_model.dart';

sealed class SuppliersState extends Equatable {
  const SuppliersState();

  @override
  List<Object?> get props => [];
}

final class SuppliersInitial extends SuppliersState {}
final class SuppliersLoading extends SuppliersState {}
final class SuppliersFailure extends SuppliersState {
  final String errorMessage;
  const SuppliersFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class SuppliersSuccess extends SuppliersState {
  final List<SupplierModel> suppliers;
  const SuppliersSuccess(this.suppliers);

  @override
  List<Object?> get props => [suppliers];
}

final class SuppliersCreateSuccess extends SuppliersState {
  final String message;
  const SuppliersCreateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
