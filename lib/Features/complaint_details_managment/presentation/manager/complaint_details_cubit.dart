import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/data/repos/complaint_details_repo.dart';

import 'complaint_details_state.dart';

class ComplaintDetailsCubit extends Cubit<ComplaintDetailsState> {
  final ComplaintDetailsRepo _repo;

  ComplaintDetailsCubit(this._repo) : super(const ComplaintDetailsState());

  Future<void> fetchComplaintDetails({required int complaintId}) async {
    print('🔄 بدء تحميل تفاصيل الشكوى (ID: $complaintId)');

    emit(state.copyWith(
      isLoadingDetails: true,
      detailsError: null,
    ));

    final result = await _repo.getComplaintDetails(complaintId: complaintId);

    result.fold(
      (failure) {
        print('❌ فشل في تحميل التفاصيل: ${failure.eerMessage}');
        emit(state.copyWith(
          isLoadingDetails: false,
          detailsError: failure.eerMessage,
        ));
      },
      (detailsResponse) {
        print('✅ تم استلام الرد من الخادم: $detailsResponse');

        final complaint = detailsResponse.data;
        if (complaint == null) {
          print('⚠️ لا توجد بيانات داخل response.data');
          emit(state.copyWith(
            isLoadingDetails: false,
            detailsError: "No complaint details found",
          ));
          return;
        }

        print('✅ تم استخراج complaint بنجاح: $complaint');
        print('🧾 الردود داخل complaint: ${complaint.responses}');

        emit(state.copyWith(
          isLoadingDetails: false,
          complaint: complaint,
          detailsError: null,
        ));
      },
    );
  }

  Future<bool> addComplaintResponse({
  required int complaintId,
  required String content,
}) async {
  emit(state.copyWith(
    addReplyStatus: AddReplyStatus.loading,
    addReplyError: null,
  ));

  final result = await _repo.addComplaintResponse(
    complaintId: complaintId,
    content: content,
  );

  return result.fold(
    (failure) {
      emit(state.copyWith(
        addReplyStatus: AddReplyStatus.error,
        addReplyError: failure.eerMessage,
      ));
      return false;
    },
    (_) async {
      await fetchComplaintDetails(complaintId: complaintId);
      return true;
    },
  );
}

}
