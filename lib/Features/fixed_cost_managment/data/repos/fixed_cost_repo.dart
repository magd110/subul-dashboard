import 'package:dartz/dartz.dart';
import 'package:subul_dashboard2/Features/fixed_cost_managment/data/models/fixed_cost_model.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';

abstract class FixedCostRepo {
  Future<Either<Failure, List<FixedCostModel>>> getFixedCosts();
  Future<Either<Failure, Map<String,dynamic>>> updateFixedCost(
    int id, {
    required String value,
   
  });
}
