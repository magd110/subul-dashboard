import 'package:equatable/equatable.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/data/models/supplier_model.dart';

sealed class CreateSupplierState extends Equatable {
  const CreateSupplierState();

  @override
  List<Object?> get props => [];
}

final class CreateSupplierInitial extends CreateSupplierState {}

final class CreateSupplierLoading extends CreateSupplierState {}

final class CreateSupplierSuccess extends CreateSupplierState {
  final SupplierModel supplier;

  const CreateSupplierSuccess(this.supplier);

  @override
  List<Object?> get props => [supplier];
}

final class CreateSupplierFailure extends CreateSupplierState {
  final String errorMessage;

  const CreateSupplierFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
