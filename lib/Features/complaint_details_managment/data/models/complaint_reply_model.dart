import 'package:equatable/equatable.dart';

class ComplaintReplyModel extends Equatable {
  final int id;
  final String content;
  final int userId;
  final String? userName;
  final String? userRole;
final String? createdAt;

  const ComplaintReplyModel({
    required this.id,
    required this.content,
    required this.userId,
    this.userName,
    this.userRole,
    this.createdAt,
  });

  factory ComplaintReplyModel.fromJson(Map<String, dynamic> json) {
    return ComplaintReplyModel(
      id: json['id'] as int,
      content: json['content'] as String,
      userId: json['user_id'] as int,
      userName: json['user_name'] as String?,
      userRole: json['user_role'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'user_id': userId,
        'user_name': userName,
        'user_role': userRole,
        'created_at': createdAt,
      };

  @override
  List<Object?> get props => [
        id,
        content,
        userId,
        userName,
        userRole,
        createdAt,
      ];
}
