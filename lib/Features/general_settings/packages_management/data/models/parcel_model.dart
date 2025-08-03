import 'package:equatable/equatable.dart';

class ParcelModel extends Equatable {
  final int id;
  final String content;
  final int isAllowed;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  const ParcelModel({
    required this.id,
    required this.content,
    required this.isAllowed,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ParcelModel.fromJson(Map<String, dynamic> json) {
    return ParcelModel(
      id: json['id'] as int,
      content: json['content'] as String? ?? '',
      isAllowed: int.parse(json['is_allowed'].toString()),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'is_allowed': isAllowed,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
      };

  @override
  List<Object?> get props => [id, content, isAllowed];
}
