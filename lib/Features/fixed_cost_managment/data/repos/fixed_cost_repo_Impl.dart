import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/data/models/fixed_cost_model.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/data/models/fixed_cost_response_model.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/data/repos/fixed_cost_repo.dart';

import 'package:subul_dashboard2/core/errors/failures.dart';
import 'package:subul_dashboard2/core/utils/api_service.dart';
import 'package:subul_dashboard2/core/utils/shared_preference_store.dart';

class FixedCostRepoImpl implements FixedCostRepo {
  final ApiService _apiService;

  FixedCostRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<FixedCostModel>>> getFixedCosts() async {
    try {
      print("+++++++++++++++++++++++++++++++++++++++++++++1");
      final token = prefs.getString('token') ?? '';
      final responseData = await _apiService.getFixedCosts(
          endPoint: 'get/fixed-costs', token: token);

      final response = FixedCostResponseModel.fromJson(responseData);

      if (response.data == null || response.data!.isEmpty) {
        return left(ServerFailure("No fixed costs found"));
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
  Future<Either<Failure, Map<String, dynamic>>> updateFixedCost(
    int id, {
    required String value,
  }) async {
    try {
      final token = prefs.getString('token') ?? '';
      final response = await _apiService.updateFixedCost(
        token: token,
        value: value,
        endPoint: 'update/fixed-costs/$id',
      );

      await getFixedCosts();

      return right(response);
    } catch (e) {
      if (e is DioException) {
        // طباعة كل تفاصيل الخطأ
        print("🔹 DioException Occurred:");
        print("Status Code: ${e.response?.statusCode}");
        print("Status Message: ${e.response?.statusMessage}");
        print("Response Data: ${e.response?.data}");
        print("Request Path: ${e.requestOptions.path}");
        print("Request Method: ${e.requestOptions.method}");

        return left(ServerFailure.fromDioError(e));
      } else {
        print("🔹 Unknown Exception: $e");
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
