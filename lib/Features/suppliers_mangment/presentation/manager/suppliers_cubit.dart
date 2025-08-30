import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/data/repos/supplier_repo.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/presentation/manager/suppliers_state.dart';

class SuppliersCubit extends Cubit<SuppliersState> {
  final SupplierRepo _repo;

  SuppliersCubit(this._repo) : super(SuppliersInitial());

  Future<void> getSuppliers() async {
    emit(SuppliersLoading());
    final result = await _repo.getSuppliers();

    result.fold(
      (failure) => emit(SuppliersFailure(failure.eerMessage)),
      (suppliersList) => emit(SuppliersSuccess(suppliersList)),
    );
  }
}
