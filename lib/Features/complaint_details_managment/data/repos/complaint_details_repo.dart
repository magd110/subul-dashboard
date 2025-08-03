
import 'package:dartz/dartz.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/data/models/complaint_reply_model.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';

import '../models/complaint_details_response_model.dart';
import 'package:dio/dio.dart';

abstract class ComplaintDetailsRepo {
  Future<Either<Failure, ComplaintDetailsResponseModel>> getComplaintDetails({
    required int complaintId
  });

   // تابع جديد لإضافة رد
  Future<Either<Failure, ComplaintReplyModel>> addComplaintResponse({
    required int complaintId,
    required String content,
  });
}
