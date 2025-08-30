import 'package:subul_dashboard2/Features/fixed_cost_managment/data/models/fixed_cost_model.dart';

class FixedCostResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final List<FixedCostModel>? data;

  FixedCostResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory FixedCostResponseModel.fromJson(Map<String, dynamic> json) {
    return FixedCostResponseModel(
      success: json['success'],
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FixedCostModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "data": data?.map((e) => e.toJson()).toList(),
      };
}
