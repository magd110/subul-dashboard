import 'package:equatable/equatable.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/data/models/user_model.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserFailure extends UserState {
  final String errorMessage;

  const UserFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class UserSuccess extends UserState {
  final List<UserModel> users;

  const UserSuccess(this.users);

  @override
  List<Object?> get props => [users];
}
final class UserDeleteSuccess extends UserState {
  final String message;

  const UserDeleteSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
final class UserUpdateRoleSuccess extends UserState {
  final String message;

  const UserUpdateRoleSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

