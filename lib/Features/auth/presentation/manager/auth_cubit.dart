import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/auth/data/models/login_response_model.dart';
import 'package:subul_dashboard2/Features/auth/data/repos/auth_repo.dart';
import 'package:subul_dashboard2/Features/auth/presentation/manager/auth_state.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';
import 'package:subul_dashboard2/core/utils/shared_preference_store.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _repo;

  AuthCubit(this._repo) : super(AuthInitial());
  Future<void> _saveTokenAndEmitSuccess(LoginResponseModel response) async {
    print("✅ Saving token...");
    try {
      await setToSharedPreference(
        key: 'token',
        token: response.data ?? '',
      );
      print("✅ Done saving, now emit success!");
      emit(AuthSuccess(response));
      print("✅ After emit: state = $state");
    } catch (e, s) {
      print("❌ Error saving token: $e");
      print("❌ StackTrace: $s");
      emit(AuthFailure("حدث خطأ أثناء حفظ التوكين"));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final Either<Failure, LoginResponseModel> result = await _repo.login(
      email: email,
      password: password,
    );
    print("Result is Right: ${result.isRight()}");
    result.fold(
      (failure) {
        emit(AuthFailure(failure.eerMessage));
      },
      (response) async {
        _saveTokenAndEmitSuccess(response);
      },
    );
  }
}
