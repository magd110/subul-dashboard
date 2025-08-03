import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/repos/complaints_repo.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/presentation/manager/complaints_state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  final ComplaintsRepo _repo;

  ComplaintsCubit(this._repo) : super(ComplaintsInitial());

  Future<void> fetchComplaints() async {
    emit(ComplaintsLoading());

    final result = await _repo.getComplaints();

    result.fold(
      (failure) => emit(ComplaintsFailure(failure.eerMessage)),
      (complaints) => emit(ComplaintsSuccess(complaints)),
    );
  }

  



}

