import 'package:dartz/dartz.dart';
import 'package:subul_dashboard2/Features/general_settings/delivery_staff_management/data/models/delivery_staff_model.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';


abstract class DeliveryStaffRepo {
  Future<Either<Failure, List<DeliveryStaffModel>>> getDeliveryStaff();
  Future<Either<Failure, Map<String,dynamic>>> deleteDeliveryStaff(int id);
  Future<Either<Failure, Map<String, dynamic>>> createDeliveryStaff({
  required String name,
  required String address,
  required String phone,
  required String jobTitle,
});
 Future<Either<Failure, Map<String, dynamic>>> updateDeliveryStaff(
    int id, {
    required String name,
    required String address,
    required String phone,
    required String jobTitle,
  });

}
