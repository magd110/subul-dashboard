import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/models/country_create_response_model.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/models/country_model.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/models/country_response_model.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/repos/get_countries_repo.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';
import 'package:subul_dashboard2/core/utils/api_service.dart';
import 'package:subul_dashboard2/core/utils/shared_preference_store.dart';

class GetCountriesRepoImpl implements GetCountriesRepo {
  final ApiService _apiService;

  GetCountriesRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<CountryModel>>> getCountries() async {
    try {
      //final String token = prefs.getString('token')!;
      final token = prefs.getString('token') ?? '';

      var responseData = await _apiService.getCountries(
        endPoint: "get/countries",
        token: "Bearer $token",
      );
      print(35);

      final response = CountryResponseModel.fromJson(responseData);
      print(36);
      if (response.data == null) {
        return left(ServerFailure("Empty country list"));
      }

      return right(response.data!);
    } catch (e) {
      print(37);
      print(e);
      print(38);
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, CountryModel>> createCountry({
    required String name,
    required String code,
  }) async {
    print(33);
    try {
      final token = prefs.getString('token') ?? '';
      // استبدله بـ token من SharedPreferences إذا لزم
      print(34);
      final responseData = await _apiService.createCountry(
        endPoint: "create/countries",
        token: "Bearer $token",
        name: name,
        code: code,
      );
      print(35);

      final response = CountryCreateResponseModel.fromJson(responseData);
      print(36);
      if (response.data == null) {
        return left(ServerFailure("Failed to create country"));
      }

      return right(response.data!);
    } catch (e) {
      print('📛 Dio Error: $e');
      if (e is DioException) {
        print('❌ Dio error: ${e.message}');
        print('📟 Response: ${e.response}');
        print('🌐 Type: ${e.type}');
        return left(ServerFailure.fromDioError(e));
      } else {
        print('🔥 Unexpected error: $e');
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
