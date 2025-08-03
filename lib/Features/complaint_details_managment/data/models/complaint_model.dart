import 'package:equatable/equatable.dart';
import 'complaint_reply_model.dart';

class ComplaintModel extends Equatable {
  final int id;
  final int userId;
  final String userName;
  final String description;
  final int isSolved;
  final String? resolutionNotes;
  final String? resolvedAt;
  final DateTime? createdAt;
  final List<ComplaintReplyModel>? responses;

  const ComplaintModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.description,
    required this.isSolved,
    this.resolutionNotes,
    this.resolvedAt,
    this.createdAt,
    this.responses,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      userName: json['user_name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      isSolved: int.parse(json['is_solved'].toString()),
      resolutionNotes: json['resolution_notes'] as String?,
      resolvedAt: json['resolved_at'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      responses: (json['responses'] as List<dynamic>?)
          ?.map((e) => ComplaintReplyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'user_name': userName,
        'description': description,
        'is_solved': isSolved,
        'resolution_notes': resolutionNotes,
        'resolved_at': resolvedAt,
        'created_at': createdAt,
        'responses': responses?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        description,
        isSolved,
        resolutionNotes,
        resolvedAt,
        createdAt,
        responses,
      ];
}
