import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/repos/complaints_repo.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/presentation/manager/complaints_state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  final ComplaintsRepo _repo;

  ComplaintsCubit(this._repo) : super(ComplaintsInitial());

  Future<void> fetchComplaints() async {
    print("🔹 fetchComplaints() called");
    emit(ComplaintsLoading());
    print("🔹 State emitted: ComplaintsLoading");

    final result = await _repo.getComplaints();
    print("🔹 Result received from repository");
    result.fold(
      (failure) {
        // طباعة رسالة الخطأ في الـ console
        print("🔹 Error received from repository: ${failure.eerMessage}");
        emit(ComplaintsFailure(failure.eerMessage));
      },
      (complaints) {
        emit(ComplaintsSuccess(complaints));
      },
    );
  }
}
