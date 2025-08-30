import 'package:dartz/dartz.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/data/models/supplier_model.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';

abstract class SupplierRepo {
  Future<Either<Failure, List<SupplierModel>>> getSuppliers();

  Future<Either<Failure, SupplierModel>> createSupplier({
    required String name,
    required String email,
    required String phone,
    required String address,
  });
}
