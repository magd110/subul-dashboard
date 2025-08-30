import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/dashboard/data/repos/get_dashboard_repo.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardRepo _dashboardRepo;

  DashboardCubit(this._dashboardRepo) : super(DashboardInitial());

Future<void> fetchDashboardStatistics({
  String? fromDate,
  String? toDate,
  String? status,
  int? customerId,
}) async {
  emit(DashboardLoading());

  final result = await _dashboardRepo.getDashboardStatistics(
    fromDate: fromDate,
    toDate: toDate,
    status: status,
    customerId: customerId,
  );

  result.fold(
    (failure) => emit(DashboardFailure(failure.eerMessage)), // تصحيح الاسم
    (dashboardData) => emit(DashboardSuccess(dashboardData)),
  );
}

}
