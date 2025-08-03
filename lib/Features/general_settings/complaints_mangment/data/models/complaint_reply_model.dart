class ComplaintReplyModel {
  final int id;
  final int complaintId;
  final int userId;
  final String content;
  final String? createdAt;
  final String? updatedAt;

  ComplaintReplyModel({
    required this.id,
    required this.complaintId,
    required this.userId,
    required this.content,
    this.createdAt,
    this.updatedAt,
  });

  factory ComplaintReplyModel.fromJson(Map<String, dynamic> json) {
    return ComplaintReplyModel(
      id: json['id'] as int,
      complaintId: int.parse(json['complaint_id'].toString()),
      userId: json['user_id'] as int,
      content: json['content'] as String,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'complaint_id': complaintId,
        'user_id': userId,
        'content': content,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
