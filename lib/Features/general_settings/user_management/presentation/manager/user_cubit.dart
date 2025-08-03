import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/data/repos/user_repo%20.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/presentation/manager/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo _repo;

  UserCubit(this._repo) : super(UserInitial());

  Future<void> getUsers() async {
    emit(UserLoading());
    final result = await _repo.getUsers();
    result.fold(
      (failure) => emit(UserFailure(failure.eerMessage)),
      (users) => emit(UserSuccess(users)),
    );
  }

  Future<void> deleteUser(int id) async {
  emit(UserLoading());

  final result = await _repo.deleteUser(id);

  result.fold(
    (failure) => emit(UserFailure(failure.eerMessage)),
    (_) async {
      emit(UserDeleteSuccess("تم حذف المستخدم بنجاح"));
      await getUsers(); // إعادة التحديث بعد نجاح الحذف
    },
  );
}
Future<void> updateUserRole({
  required int userId,
  required String newRole,
}) async {
   print("2");
  emit(UserLoading());

  final result = await _repo.updateUserRole(
    userId: userId,
    newRole: newRole,
  );
   print("21");

  result.fold(
    (failure) => emit(UserFailure(failure.eerMessage)),
    (_) async {
      emit(UserUpdateRoleSuccess("تم تحديث الدور بنجاح"));
      await getUsers(); // إعادة تحميل المستخدمين بعد التحديث
    },
  );
}

}
