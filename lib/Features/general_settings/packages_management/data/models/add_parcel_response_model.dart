import 'package:subul_dashboard2/Features/general_settings/packages_management/data/models/parcel_model.dart';

class AddParcelResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final ParcelModel? data;

  AddParcelResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory AddParcelResponseModel.fromJson(Map<String, dynamic> json) {
    return AddParcelResponseModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ParcelModel.fromJson(json['data'] as Map<String, dynamic>)
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
