import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/data/repos/parcels_repo.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/presentation/manager/add_parcel_state.dart';

class AddParcelCubit extends Cubit<AddParcelState> {
  final ParcelsRepo _repo;

  AddParcelCubit(this._repo) : super(AddParcelInitial());

  Future<void> addParcel({
    required String content,
    required int isAllowed,
  }) async {
    emit(AddParcelLoading());

    final result = await _repo.addParcel(
      content: content,
      isAllowed: isAllowed,
    );

    result.fold(
      (failure) => emit(AddParcelFailure(failure.eerMessage)),
      (parcel) => emit(AddParcelSuccess(parcel)),
    );
  }
}
