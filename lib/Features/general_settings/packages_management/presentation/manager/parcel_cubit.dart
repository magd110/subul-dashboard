import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/data/repos/parcels_repo.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/presentation/manager/parcel_state.dart'
    show
        ParcelFailure,
        ParcelInitial,
        ParcelLoading,
        ParcelState,
        ParcelSuccess;

class ParcelCubit extends Cubit<ParcelState> {
  final ParcelsRepo _repo;

  ParcelCubit(
    this._repo,
  ) : super(ParcelInitial());

  Future<void> fetchParcels() async {
    emit(ParcelLoading());

    final result = await _repo.getParcels();

    result.fold(
      (failure) => emit(ParcelFailure(failure.eerMessage)),
      (parcels) => emit(ParcelSuccess(parcels)),
    );
  }

  Future<void> updateParcelStatus({
    required int id,
    required int newStatus,
  }) async {
    print("updateParcelStatus1");
    // لا حاجة لحالة خاصة هنا، فقط نُحدث ونُعيد الجلب
    final result = await _repo.updateParcelPermission(
      parcelId: id,
      isAllowed: newStatus,
    );
    print("updateParcelStatus12");

    result.fold(
      (failure) {
        emit(ParcelFailure(failure.eerMessage));
      },
      (updatedParcel) async {
        await fetchParcels(); // نجدد القائمة بعد التحديث
      },
    );
  }
}
