import 'package:equatable/equatable.dart';

class DeliveryStaffModel extends Equatable {
  final int? id;
  final String name;
  final String address;
  final String phone;
  final String jobTitle;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  const DeliveryStaffModel({
    this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.jobTitle,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory DeliveryStaffModel.fromJson(Map<String, dynamic> json) {
    return DeliveryStaffModel(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      jobTitle: json['job_title'] as String? ?? '',
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'phone': phone,
        'job_title': jobTitle,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
      };

  @override
  List<Object?> get props => [id, name, phone];
}
