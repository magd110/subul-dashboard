import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:subul_dashboard2/Features/dashboard/data/models/dashboard_response_model.dart';
import 'package:subul_dashboard2/Features/dashboard/data/models/dashboard_statistics_model.dart';
import 'package:subul_dashboard2/Features/dashboard/data/repos/get_dashboard_repo.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';
import 'package:subul_dashboard2/core/utils/api_service.dart';
import 'package:subul_dashboard2/core/utils/shared_preference_store.dart';

class GetDashboardRepoImpl implements GetDashboardRepo {
  final ApiService _apiService;

  GetDashboardRepoImpl(this._apiService);

  @override
  Future<Either<Failure, DashboardStatisticsModel>> getDashboardStatistics({
    String? fromDate,
    String? toDate,
    String? status,
    int? customerId,
  }) async {
    try {
      final token = prefs.getString('token') ?? '';

      // بناء الـ query params بشكل ديناميكي
      final queryParams = {
        if (fromDate != null) 'from_date': fromDate,
        if (toDate != null) 'to_date': toDate,
        if (status != null) 'status': status,
        if (customerId != null) 'customer_id': customerId.toString(),
      };

      final responseData = await _apiService.getDashboardData(
        endPoint: "get/statistics",
        token: token,
        queryParameters: queryParams,
      );

      final dashboardResponse = DashboardResponseModel.fromJson(responseData);

      if (dashboardResponse.data == null) {
        return left(ServerFailure("No dashboard data found"));
      }

      return right(dashboardResponse.data!);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
