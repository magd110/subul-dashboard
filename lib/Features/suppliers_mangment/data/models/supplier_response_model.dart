import 'package:subul_dashboard2/Features/suppliers_mangment/data/models/supplier_model.dart';

class SupplierResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final List<SupplierModel>? data;

  SupplierResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory SupplierResponseModel.fromJson(Map<String, dynamic> json) {
    return SupplierResponseModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SupplierModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
