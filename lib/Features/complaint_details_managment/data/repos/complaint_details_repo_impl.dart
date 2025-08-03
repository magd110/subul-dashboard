import 'package:dartz/dartz.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/data/models/complaint_details_response_model.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/data/models/complaint_reply_model.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';
import 'package:subul_dashboard2/core/utils/api_service.dart';
import 'package:subul_dashboard2/core/utils/shared_preference_store.dart';

import 'package:dio/dio.dart';

import 'complaint_details_repo.dart';

class ComplaintDetailsRepoImpl implements ComplaintDetailsRepo {
  final ApiService _apiService;

  ComplaintDetailsRepoImpl(this._apiService);

  @override
  Future<Either<Failure, ComplaintDetailsResponseModel>> getComplaintDetails(
      {required int complaintId}) async {
    try {
      final token = prefs.getString('token') ?? '';

      final responseData = await _apiService.getComplaintDetails(
        endPoint: 'get/one/complaints/${complaintId}',
        token: token,
      );

      final detailsResponse =
          ComplaintDetailsResponseModel.fromJson(responseData);
      print('Complaint details: ${detailsResponse.data}');
      print('Responses: ${detailsResponse.data?.responses}');

      if (detailsResponse.data == null) {
        return left(ServerFailure("No complaint details found"));
      }

      return right(detailsResponse);
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
  Future<Either<Failure, ComplaintReplyModel>> addComplaintResponse({
    required int complaintId,
    required String content,
  }) async {
    try {
      final token = prefs.getString('token') ?? '';
      final responseData = await _apiService.addComplaintResponse(
        endPoint: "complaints/responses/${complaintId}",
        token: token,
        content: content,
      );
      print('RESPONSE DATA: ${responseData}');

      final replyResponse = ComplaintReplyModel.fromJson(responseData['data']);

      // هنا تحوّل data إلى ComplaintReplyModel
      return right(replyResponse);
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
