import 'package:dartz/dartz.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/models/complaint_model.dart';
import 'package:subul_dashboard2/Features/general_settings/complaints_mangment/data/models/complaint_reply_model.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';

abstract class ComplaintsRepo {
  Future<Either<Failure, List<ComplaintModel>>> getComplaints();


 
}