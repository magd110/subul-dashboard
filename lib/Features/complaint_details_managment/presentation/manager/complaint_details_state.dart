import 'package:equatable/equatable.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/data/models/complaint_model.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/data/models/complaint_reply_model.dart';

enum AddReplyStatus { initial, loading, success, error }

class ComplaintDetailsState {
  final bool isLoadingDetails;
  final ComplaintModel? complaint;
  final AddReplyStatus addReplyStatus;
  final String? detailsError;
  final String? addReplyError;

  const ComplaintDetailsState({
    this.isLoadingDetails = false,
    this.complaint,
    this.addReplyStatus = AddReplyStatus.initial,
    this.detailsError,
    this.addReplyError,
  });

  ComplaintDetailsState copyWith({
    bool? isLoadingDetails,
    ComplaintModel? complaint,
    AddReplyStatus? addReplyStatus,
    String? detailsError,
    String? addReplyError,
  }) {
    return ComplaintDetailsState(
      isLoadingDetails: isLoadingDetails ?? this.isLoadingDetails,
      complaint: complaint ?? this.complaint,
      addReplyStatus: addReplyStatus ?? this.addReplyStatus,
      detailsError: detailsError,
      addReplyError: addReplyError,
    );
  }
}



