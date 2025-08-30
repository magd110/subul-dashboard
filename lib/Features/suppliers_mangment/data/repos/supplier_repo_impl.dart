import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/data/models/supplier_model.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/data/models/create_supplier_response_model.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/data/models/supplier_response_model.dart';
import 'package:subul_dashboard2/Features/suppliers_mangment/data/repos/supplier_repo.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';
import 'package:subul_dashboard2/core/utils/api_service.dart';
import 'package:subul_dashboard2/core/utils/shared_preference_store.dart';

class SupplierRepoImpl implements SupplierRepo {
  final ApiService _apiService;
  SupplierRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<SupplierModel>>> getSuppliers() async {
    try {
      final token = prefs.getString('token') ?? '';
      final responseData = await _apiService.getSuppliers(
        endPoint: "suppliers",
        token: token,
      );

      final response = SupplierResponseModel.fromJson(responseData);

      if (response.data == null || response.data!.isEmpty) {
        return left(ServerFailure("No suppliers found"));
      }

      return right(response.data!);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, SupplierModel>> createSupplier({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    try {
      final token = prefs.getString('token') ?? '';
      print("token : $token");
      final responseData = await _apiService.createSupplier(
        token: token,
        name: name,
        email: email,
        phone: phone,
        address: address,
        endPoint: 'createsupplir', // الاسم حسب الـ API
      );

      print("$responseData");

      final response = CreateSupplierResponseModel.fromJson(responseData);

      if (response.data == null) {
        print("❌ Supplier creation failed: response data is null");
        return left(ServerFailure("Supplier creation failed"));
      }

      return right(response.data!);
    } catch (e, stackTrace) {
      print("❌ Exception caught in createSupplier:");
      print("Type: ${e.runtimeType}");
      print("Error: $e");
      print("StackTrace: $stackTrace");

      if (e is DioException) {
        print("DioException details:");
        print("Message: ${e.message}");
        print("RequestOptions: ${e.requestOptions}");
        print("Response: ${e.response}");
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
