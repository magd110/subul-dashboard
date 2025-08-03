import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/models/complaint_model.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/models/complaint_reply_model.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/models/complaint_reply_response_model.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/models/complaint_response_model.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/repos/complaints_repo.dart';

import 'package:subul_dashboard2/core/errors/failures.dart';
import 'package:subul_dashboard2/core/utils/api_service.dart';
import 'package:subul_dashboard2/core/utils/shared_preference_store.dart';

class ComplaintsRepoImpl implements ComplaintsRepo {
  final ApiService _apiService;

  ComplaintsRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<ComplaintModel>>> getComplaints() async {
    try {
      final token = prefs.getString('token') ?? '';
      print("3");
      final responseData = await _apiService.getComplaints(
        endPoint: "get/all/complaints",
        token: token,
      );
      print("31");

      final complaintsResponse = ComplaintResponseModel.fromJson(responseData);

      if (complaintsResponse.data == null || complaintsResponse.data!.isEmpty) {
        return left(ServerFailure("No complaints found"));
      }

      return right(complaintsResponse.data!);
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
