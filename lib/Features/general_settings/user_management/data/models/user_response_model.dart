import 'package:subul_dashboard2/Features/general_settings/user_management/data/models/user_model.dart';

class UserResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final List<UserModel>? data;

  UserResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
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
