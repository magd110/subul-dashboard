import 'package:equatable/equatable.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/models/complaint_model.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/models/complaint_reply_model.dart';

sealed class ComplaintsState extends Equatable {
  const ComplaintsState();

  @override
  List<Object?> get props => [];
}

// حالات تحميل الشكاوي
final class ComplaintsInitial extends ComplaintsState {}

final class ComplaintsLoading extends ComplaintsState {}

final class ComplaintsSuccess extends ComplaintsState {
  final List<ComplaintModel> complaints;
  const ComplaintsSuccess(this.complaints);

  @override
  List<Object?> get props => [complaints];
}

final class ComplaintsFailure extends ComplaintsState {
  final String errorMessage;
  const ComplaintsFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}





