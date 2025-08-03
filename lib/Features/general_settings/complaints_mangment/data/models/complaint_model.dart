import 'package:equatable/equatable.dart';

class ComplaintModel extends Equatable {
  final int id;
  final int userId;
  final int shipmentId;
  final int? parcelId;
  final String description;
  final int isSolved;
  final String? resolutionNotes;
  final String? resolvedAt;
  final String? createdAt;
  final String? updatedAt;

  const ComplaintModel({
    required this.id,
    required this.userId,
    required this.shipmentId,
    this.parcelId,
    required this.description,
    required this.isSolved,
    this.resolutionNotes,
    this.resolvedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      shipmentId: json['shipment_id'] as int,
      parcelId: json['parcel_id'] as int?, // nullable
      description: json['description'] as String? ?? '',
      isSolved: int.parse(json['is_solved'].toString()),
      resolutionNotes: json['resolution_notes'] as String?,
      resolvedAt: json['resolved_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'shipment_id': shipmentId,
        'parcel_id': parcelId,
        'description': description,
        'is_solved': isSolved,
        'resolution_notes': resolutionNotes,
        'resolved_at': resolvedAt,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  @override
  List<Object?> get props => [
        id,
        userId,
        shipmentId,
        parcelId,
        description,
        isSolved,
      ];
}
