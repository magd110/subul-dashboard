import 'package:equatable/equatable.dart';

class FixedCostModel extends Equatable {
  final int id;
  final String name;
  final String value;
  final bool isActive;
  final int? createdByUserId;
  final int? updatedByUserId;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;

  const FixedCostModel({
    required this.id,
    required this.name,
    required this.value,
    required this.isActive,
    this.createdByUserId,
    this.updatedByUserId,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory FixedCostModel.fromJson(Map<String, dynamic> json) {
    return FixedCostModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      value: json['value'] ?? '',
      isActive: json['is_active'] ?? false,
      createdByUserId: json['created_by_user_id'],
      updatedByUserId: json['updated_by_user_id'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "value": value,
        "is_active": isActive,
        "created_by_user_id": createdByUserId,
        "updated_by_user_id": updatedByUserId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };

  @override
  List<Object?> get props => [id, name, value, isActive];
}
