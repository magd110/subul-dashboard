import 'complaint_model.dart';

class ComplaintDetailsResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final ComplaintModel? data;

  ComplaintDetailsResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory ComplaintDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return ComplaintDetailsResponseModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ComplaintModel.fromJson(json['data'] as Map<String, dynamic>)
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
