import 'dashboard_statistics_model.dart';

class DashboardResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final DashboardStatisticsModel? data;

  DashboardResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    return DashboardResponseModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? DashboardStatisticsModel.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
