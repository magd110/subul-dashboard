import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/data/models/user_model.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/data/models/user_response_model.dart';
import 'package:subul_dashboard2/Features/general_settings/user_management/data/repos/user_repo%20.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';
import 'package:subul_dashboard2/core/utils/api_service.dart';
import 'package:subul_dashboard2/core/utils/shared_preference_store.dart';

class UserRepoImpl implements UserRepo {
  final ApiService _apiService;

  UserRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<UserModel>>> getUsers() async {
    try {
      final token = prefs.getString('token') ?? '';

      final responseData = await _apiService.getUsers(
        endPoint: "get/users",
        token: token,
      );

      final response = UserResponseModel.fromJson(responseData);

      if (response.data == null || response.data!.isEmpty) {
        return left(ServerFailure("No users found"));
      }

      return right(response.data!);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteUser(int id) async {
    try {
      final token = prefs.getString('token') ?? '';

      final response = await _apiService.deleteUser(
        id: id,
        token: token,
        endPoint: "/api/users/$id",
      );

      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateUserRole({
    required int userId,
    required String newRole,
  }) async {
    try {
      print("3");
      final token = prefs.getString('token') ?? '';
      print("31");
      final response = await _apiService.updateUserRole(
        newRole: newRole,
        token: token,
        endPoint: "update/users/role/${userId}",
      );
      print("32");

      return right(response);
    } catch (e) {
      print("-------------------");
      print(e);
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
