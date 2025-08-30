import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/data/repos/supplier_repo.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/presentation/manager/create_supplier_state.dart';

class CreateSupplierCubit extends Cubit<CreateSupplierState> {
  final SupplierRepo _repo;

  CreateSupplierCubit(this._repo) : super(CreateSupplierInitial());

  Future<void> createSupplier({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    emit(CreateSupplierLoading());

    final result = await _repo.createSupplier(
      name: name,
      email: email,
      phone: phone,
      address: address,
    );

    result.fold(
      (failure) => emit(CreateSupplierFailure(failure.eerMessage)),
      (supplier) => emit(CreateSupplierSuccess(supplier)),
    );
  }
}
