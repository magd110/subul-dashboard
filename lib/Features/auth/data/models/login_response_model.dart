class LoginResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final LoginData? data;

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
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}

class LoginData {
  final User? user;
  final String? role;
  final String? token;

  LoginData({this.user, this.role, this.token});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      role: json['role'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'role': role,
        'token': token,
      };
}

class User {
  final int? id;
  final String? role;
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  User({
    this.id,
    this.role,
    this.firstName,
    this.lastName,
    this.email,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      role: json['role'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      status: json['status'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
