import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/data/models/delivery_staff_model.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/data/models/delivery_staff_response_model.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/data/repos/delivery_staff_repo%20.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';
import 'package:subul_dashboard2/core/utils/api_service.dart';
import 'package:subul_dashboard2/core/utils/shared_preference_store.dart';

class DeliveryStaffRepoImpl implements DeliveryStaffRepo {
  final ApiService _apiService;

  DeliveryStaffRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<DeliveryStaffModel>>> getDeliveryStaff() async {
    try {
      print("1");
      final token = prefs.getString('token') ?? '';
      print("2");
      final responseData = await _apiService.getDeliveryStaff(
        endPoint: "get/delivery-staff",
        token: token,
      );
      print("3");
      final response = DeliveryStaffResponseModel.fromJson(responseData);

      if (response.data == null || response.data!.isEmpty) {
        return left(ServerFailure("No delivery staff found"));
      }

      return right(response.data!);
    } catch (e) {
      print(e);
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteDeliveryStaff(
      int id) async {
    try {
      print("3");
      final token = prefs.getString('token') ?? '';
      final response = await _apiService.deleteDeliveryStaff(
          token: token, endPoint: "dalete/delivery-staff/$id");
      print("31");
      await getDeliveryStaff();

      return right(response);
    } catch (e) {
      print("__________________");
      print(e);
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> createDeliveryStaff({
    required String name,
    required String address,
    required String phone,
    required String jobTitle,
  }) async {
    try {
      final token = prefs.getString('token') ?? '';
      final response = await _apiService.createDeliveryStaff(
        token: token,
        name: name,
        address: address,
        phone: phone,
        jobTitle: jobTitle,
        endPoint: 'create/delivery-staff',
      );

      print("Create Response: $response");

      // بعد الإضافة ممكن تحدث القائمة لو حاب
      await getDeliveryStaff();

      return right(response);
    } catch (e) {
      print(e);
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateDeliveryStaff(
    int id, {
    required String name,
    required String address,
    required String phone,
    required String jobTitle,
  }) async {
    try {
      final token = prefs.getString('token') ?? '';
      final response = await _apiService.updateDeliveryStaff(
        token: token,
        name: name,
        address: address,
        phone: phone,
        jobTitle: jobTitle,
        endPoint: 'update/delivery-staff/$id',
      );

      print("Update Response: $response");

      // بعد التحديث حدّث القائمة إذا أردت
      await getDeliveryStaff();

      return right(response);
    } catch (e) {
      print(e);
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
