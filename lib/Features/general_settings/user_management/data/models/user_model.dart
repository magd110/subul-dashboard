import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String role;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;

  const UserModel({
    required this.id,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      role: json['role'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
      };

  @override
  List<Object?> get props => [id, email, role];
}
