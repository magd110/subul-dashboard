import 'package:subul_dashboard2/Features/suppliers_mangment/data/models/supplier_model.dart';

class CreateSupplierResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final SupplierModel? data;

  CreateSupplierResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory CreateSupplierResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateSupplierResponseModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? SupplierModel.fromJson(json['data'] as Map<String, dynamic>)
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
