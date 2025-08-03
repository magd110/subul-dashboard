import 'package:dartz/dartz.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/data/models/user_model.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';

abstract class UserRepo {
  Future<Either<Failure, List<UserModel>>> getUsers();
  Future<Either<Failure, Map<String, dynamic>>> deleteUser(int id);
   Future<Either<Failure, Map<String, dynamic>>> updateUserRole({
    required int userId,
    required String newRole,
  });
}