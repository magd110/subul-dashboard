import 'package:dartz/dartz.dart';
import 'package:subul_dashboard2/Features/shipments/data/models/shipment_model.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';

abstract class ShipmentRepo {
  Future<Either<Failure, List<ShipmentModel>>> getShipments({
    List<String>? statuses,
  });
}
