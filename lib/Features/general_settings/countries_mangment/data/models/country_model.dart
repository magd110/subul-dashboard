import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  final int? id;
  final String  name;
  final String  code;
  final int? isEnabled;
  final String? createdAt;
  final String? updatedAt;

  const CountryModel({
    this.id,
    required this.name,
    required this.code,
    this.isEnabled,
    this.createdAt,
    this.updatedAt,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '' ,
      isEnabled: json['is_enabled'] as int? ?? 0,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'code': code,
        'is_enabled': isEnabled,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  @override
  List<Object?> get props => [id, name, code];
}
