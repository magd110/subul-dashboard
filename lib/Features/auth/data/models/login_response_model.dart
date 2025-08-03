class LoginResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final String? data; // هنا الـ Token

  LoginResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] as String?, // التوكن
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'status': status,
        'message': message,
        'data': data,
      };
}
