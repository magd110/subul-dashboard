import 'package:dartz/dartz.dart';
import 'package:subul_dashboard2/Features/dashboard/data/models/dashboard_statistics_model.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';

abstract class GetDashboardRepo {
  Future<Either<Failure, DashboardStatisticsModel>> getDashboardStatistics();
}
