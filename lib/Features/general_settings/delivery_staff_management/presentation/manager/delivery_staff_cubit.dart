import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/data/repos/delivery_staff_repo%20.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/presentation/manager/delivery_staff_state.dart';

class DeliveryStaffCubit extends Cubit<DeliveryStaffState> {
  final DeliveryStaffRepo _repo;

  DeliveryStaffCubit(this._repo) : super(DeliveryStaffInitial());

  Future<void> getDeliveryStaff() async {
    emit(DeliveryStaffLoading());
    final result = await _repo.getDeliveryStaff();
    result.fold(
      (failure) => emit(DeliveryStaffFailure(failure.eerMessage)),
      (staffList) => emit(DeliveryStaffSuccess(staffList)),
    );
  }

  Future<void> deleteDeliveryStaff(int id) async {
  emit(DeliveryStaffLoading());

  final result = await _repo.deleteDeliveryStaff(id);

  result.fold(
    (failure) {
      emit(DeliveryStaffFailure(failure.eerMessage));
    },
    (_) async {
      // بعد الحذف الناجح، حدّث القائمة فقط
      await getDeliveryStaff();
      // لو حابب، يمكنك إضافة منطق هنا لعرض SnackBar
    },
  );
}

  Future<void> createDeliveryStaff({
    required String name,
    required String address,
    required String phone,
    required String jobTitle,
  }) async {
    emit(DeliveryStaffLoading());

    final result = await _repo.createDeliveryStaff(
      name: name,
      address: address,
      phone: phone,
      jobTitle: jobTitle,
    );

    result.fold(
      (failure) => emit(DeliveryStaffFailure(failure.eerMessage)),
      (response) {
        // لتحديث القائمة بعد الإضافة
        getDeliveryStaff();
      },
    );
  }
  Future<void> updateDeliveryStaff({
  required int id,
  required String name,
  required String address,
  required String phone,
  required String jobTitle,
}) async {
  emit(DeliveryStaffLoading());

  final result = await _repo.updateDeliveryStaff(
    id,
    name: name,
    address: address,
    phone: phone,
    jobTitle: jobTitle,
  );

  result.fold(
    (failure) => emit(DeliveryStaffFailure(failure.eerMessage)),
    (response) async {
      // بعد التحديث الناجح، حدّث القائمة
      await getDeliveryStaff();
     
    },
  );
}

}
