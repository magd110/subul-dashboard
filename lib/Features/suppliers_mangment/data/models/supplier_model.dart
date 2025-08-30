import 'package:equatable/equatable.dart';

class SupplierModel extends Equatable {
  final int? id;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String? createdAt;
  final String? updatedAt;

  const SupplierModel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      address: json['address'] as String? ?? '',
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'address': address,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  @override
  List<Object?> get props => [id, name, phone, email];
}
