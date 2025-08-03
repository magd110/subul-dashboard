import 'package:subul_dashboard2/Features/general_settings/packages_management/data/models/parcel_model.dart';

class ParcelResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final List<ParcelModel>? data;

  ParcelResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory ParcelResponseModel.fromJson(Map<String, dynamic> json) {
    return ParcelResponseModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ParcelModel.fromJson(e as Map<String, dynamic>))
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
