import 'package:equatable/equatable.dart';
import 'package:subul_dashboard2/Features/dashboard/data/models/dashboard_statistics_model.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardFailure extends DashboardState {
  final String errorMessage;

  const DashboardFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class DashboardSuccess extends DashboardState {
  final DashboardStatisticsModel data;

  const DashboardSuccess(this.data);

  @override
  List<Object?> get props => [data];
}
