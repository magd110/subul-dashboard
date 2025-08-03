import 'package:dartz/dartz.dart';
import 'package:subul_dashboard2/Features/general_settings/packages_management/data/models/parcel_model.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';

abstract class ParcelsRepo {
  Future<Either<Failure, List<ParcelModel>>> getParcels();
  Future<Either<Failure, ParcelModel>> addParcel({
    required String content,
    required int isAllowed,

  });
 Future<Either<Failure, ParcelModel>> updateParcelPermission({
    required int parcelId,
    required int isAllowed,
  });
}