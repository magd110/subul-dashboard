import 'package:dartz/dartz.dart';
import 'package:subul_dashboard2/Features/auth/data/models/login_response_model.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginResponseModel>> login({
    required String email,
    required String password,
  });
}
