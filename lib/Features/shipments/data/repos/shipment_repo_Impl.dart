import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';
import 'package:subul_dashboard2/core/utils/api_service.dart';
import 'package:subul_dashboard2/core/utils/shared_preference_store.dart';

import '../models/shipment_model.dart';
import '../models/shipment_response_model.dart';
import 'shipment_repo.dart';

class ShipmentRepoImpl implements ShipmentRepo {
  final ApiService _apiService;
  ShipmentRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<ShipmentModel>>> getShipments({
    List<String>? statuses,
  }) async {
    try {
      final token = prefs.getString('token') ?? '';
      if (token.isEmpty) return left(ServerFailure("Token not found"));

      String endPoint = 'shipments';
      if (statuses != null && statuses.isNotEmpty) {
        final query = statuses.map((s) => 'status=$s').join('&');
        endPoint = '$endPoint?$query';
      }

      final responseData = await _apiService.getShipments(
        endPoint: endPoint,
        token: token,
      );

      final response = ShipmentResponseModel.fromJson(responseData);

      if (response.data.isEmpty) {
        return left(ServerFailure("No shipments found"));
      }

      return right(response.data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}

