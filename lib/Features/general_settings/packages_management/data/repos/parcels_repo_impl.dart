import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/data/models/add_parcel_response_model.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/data/models/parcel_model.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/data/models/parcel_response_model.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/data/repos/parcels_repo.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';
import 'package:subul_dashboard2/core/utils/api_service.dart';
import 'package:subul_dashboard2/core/utils/shared_preference_store.dart';

class ParcelsRepoImpl implements ParcelsRepo {
  final ApiService _apiService;

  ParcelsRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<ParcelModel>>> getParcels() async {
    try {
      print("1");
      final token = prefs.getString('token') ?? '';

      final responseData = await _apiService.getParcels(
        endPoint: "get/content/parcels",
        token: "Bearer $token",
      );
      print(responseData);
      print("12");

      final parcelsResponse = ParcelResponseModel.fromJson(responseData);

      if (parcelsResponse.data == null) {
        return left(ServerFailure("Empty parcel list"));
      }

      return right(parcelsResponse.data!);
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
  Future<Either<Failure, ParcelModel>> addParcel({
    required String content,
    required int isAllowed,
  }) async {
    try {
      final token = prefs.getString('token') ?? '';
      final responseData = await _apiService.addParcel(
        token: token,
        content: content,
        isAllowed: isAllowed,
        endPoint: "create/content/parcels",
      );

      final parsedResponse = AddParcelResponseModel.fromJson(responseData);

      if (parsedResponse.data == null) {
        return left(ServerFailure("Parcel creation failed"));
      }

      return right(parsedResponse.data!);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, ParcelModel>> updateParcelPermission({
    required int parcelId,
    required int isAllowed,
  }) async {
    try {
      print("updateParcelStatus22");
      final token = prefs.getString('token') ?? '';

      final responseData = await _apiService.updateParcelPermission(
        endPoint: "update/content/parcels/permission/",
        parcelId: parcelId,
        isAllowed: isAllowed,
        token: token,
      );

      print("updateParcelStatus23");
      final updatedParcel = AddParcelResponseModel.fromJson(responseData);

      if (updatedParcel.data == null) {
        return left(ServerFailure("Failed to update parcel permission"));
      }

      return right(updatedParcel.data!);
    } catch (e) {
      print("updateParcelStatus22${e}");
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
