import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/dashboard/data/repos/get_dashboard_repo.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardRepo _dashboardRepo;

  DashboardCubit(this._dashboardRepo) : super(DashboardInitial());

  Future<void> fetchDashboardStatistics() async {
    emit(DashboardLoading());

    final result = await _dashboardRepo.getDashboardStatistics();

    result.fold(
      (failure) => emit(DashboardFailure(failure.eerMessage)),
      (dashboardData) => emit(DashboardSuccess(dashboardData)),
    );
  }
}
