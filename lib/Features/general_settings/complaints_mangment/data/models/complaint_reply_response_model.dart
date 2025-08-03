import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/models/complaint_reply_model.dart';

class ComplaintReplyResponseModel {
  final bool success;
  final int status;
  final String message;
  final ComplaintReplyModel data;

  ComplaintReplyResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory ComplaintReplyResponseModel.fromJson(Map<String, dynamic> json) {
    return ComplaintReplyResponseModel(
      success: json['success'] ?? false,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: ComplaintReplyModel.fromJson(json['data']),
    );
  }
}
