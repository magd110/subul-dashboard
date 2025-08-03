
import 'package:equatable/equatable.dart';
import 'package:subul_dashboard2/Features/auth/data/models/login_response_model.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final LoginResponseModel loginResponse;

  const AuthSuccess(this.loginResponse);

  @override
  List<Object?> get props => [loginResponse];
}

final class AuthFailure extends AuthState {
  final String errorMessage;

  const AuthFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
