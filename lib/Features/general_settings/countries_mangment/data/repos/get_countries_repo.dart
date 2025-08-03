import 'package:dartz/dartz.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/models/country_model.dart';
import 'package:subul_dashboard2/core/errors/failures.dart';

abstract class GetCountriesRepo {
  Future<Either<Failure, List<CountryModel>>> getCountries();
  Future<Either<Failure, CountryModel>> createCountry({
    required String name,
    required String code,
  });
}
