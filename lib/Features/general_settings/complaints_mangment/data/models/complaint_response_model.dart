import 'complaint_model.dart';

class ComplaintResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final List<ComplaintModel>? data;

  ComplaintResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory ComplaintResponseModel.fromJson(Map<String, dynamic> json) {
    return ComplaintResponseModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ComplaintModel.fromJson(e as Map<String, dynamic>))
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
